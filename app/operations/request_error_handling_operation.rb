class RequestErrorHandlingOperation < ApplicationOperation
  task(:write_to_log)
  task(:notify_exception_service)
  task(:render_output)

  schema(:write_to_log) do
    field(:exception, :type => Types.Instance(StandardError))
  end
  def write_to_log(state:)
    case state.exception
    when StateMachines::InvalidTransition
      Rails.logger.debug("#{state.exception.object.class.name} failed to save due to #{state.exception.object.errors.full_messages.to_sentence}")
    when Pundit::NotAuthorizedError
      Rails.logger.debug("#{state.exception.policy.class.name} did not allow #{state.exception.policy.actor.to_gid} to #{state.exception.query.delete("?")} a #{state.exception.policy.record.class}")
    when ActiveRecord::RecordInvalid
      Rails.logger.error("#{state.exception.record.class.name} failed to save due to #{state.exception.record.errors.full_messages.to_sentence}")
      Rails.logger.error(state.exception.record.attributes.as_json)
    else
      Rails.logger.error("#{state.exception.class.name} was raised due to #{state.exception.message.inspect}")
    end
    Rails.logger.debug(state.exception.full_message)
  end

  schema(:notify_exception_service) do
    field(:controller, :type => Types.Instance(ApplicationController))
    field(:exception, :type => Types.Instance(StandardError))
  end
  def notify_exception_service
    return unless Rails.env.production?
  end

  schema(:render_output) do
    field(:controller, :type => Types.Instance(ApplicationController))
    field(:exception, :type => Types.Instance(StandardError))
  end
  def render_output(state:)
    case state.exception
    when JSONAPI::Materializer::Error::InvalidAcceptHeader then not_acceptable(state.controller)
    when JSONAPI::Materializer::Error::MissingAcceptHeader then not_acceptable(state.controller)
    when JSONAPI::Materializer::Error::ResourceAttributeNotFound then bad_request(state.controller)
    when JSONAPI::Materializer::Error::ResourceRelationshipNotFound then bad_request(state.controller)

    when JSONAPI::Realizer::Error::InvalidContentTypeHeader then unsuported_media_type(state.controller)
    when JSONAPI::Realizer::Error::MissingContentTypeHeader then unsuported_media_type(state.controller)
    when JSONAPI::Realizer::Error::InvalidRootProperty then unprocessable_entity(state.controller)
    when JSONAPI::Realizer::Error::MissingDataTypeProperty then unprocessable_entity(state.controller)
    when JSONAPI::Realizer::Error::IncludeWithoutDataProperty then unprocessable_entity(state.controller)
    when JSONAPI::Realizer::Error::ResourceAttributeNotFound then bad_request(state.controller)
    when JSONAPI::Realizer::Error::ResourceRelationshipNotFound then bad_request(state.controller)

    when Pundit::NotAuthorizedError then unauthorized(state.controller)

    when ActiveRecord::RecordInvalid then record_invalid(state.controller, state.exception)
    when ActiveRecord::RecordNotFound then not_found(state.controller)

    when StateMachines::InvalidTransition then invalid_transition(state.controller)

    when SmartParams::Error::InvalidPropertyType then invalid_property_type(state.controller, state.exception)

    when ApplicationError then application_exception(state.controller, state.exception)

    else internal_server_error(state.controller)
    end
  end

  private def record_invalid(controller, exception)
    controller.render(
      :json => exception.record.errors,
      :status => :unprocessable_entity,
    )
  end

  private def not_found(controller)
    controller.head(:not_found)
  end

  private def application_exception(controller, exception)
    controller.render(
      :json => standard_jsonapi_error(exception),
      :status => :unprocessable_entity,
    )
  end

  private def unprocessable_entity(controller)
    controller.head(:unprocessable_entity)
  end

  private def unsuported_media_type(controller)
    controller.head(:unsupported_media_type)
  end

  private def bad_request(controller)
    controller.head(:bad_request)
  end

  private def unauthorized(controller)
    controller.head(:unauthorized)
  end

  private def not_acceptable(controller)
    controller.head(:not_acceptable)
  end

  private def invalid_property_type(controller, exception)
    controller.render(
      :json => [
        {
          "title" => "Schema Mismatch",
          "code" => "schema_mismatch",
          "detail" => "The expected value at the pointer does not match the schema",
          "source" => {
            "expected-type" => exception.wanted.name,
            "given-type" => exception.raw.class.name,
            "pointer" => "/#{exception.keychain.join("/")}",
          },
        },
      ],
      :status => :unprocessable_entity,
    )
  end

  private def internal_server_error(controller)
    controller.head(:internal_server_error)
  end

  private def standard_jsonapi_error(exception)
    [
      {
        "title" => exception.title,
        "code" => exception.class.name.underscore,
        "detail" => exception.detail,
      },
    ]
  end
end
