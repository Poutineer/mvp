module Admin
  class AccountsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Account.
    #     page(params[:page]).
    #     per(10)
    # end

    def new
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource_class.new(audit_actor: current_account)),
      }
    end

    def edit
      render locals: {
        page: Administrate::Page::Form.new(dashboard, requested_resource.tap { |record| record.assign_attributes(audit_actor: current_account) }),
      }
    end

    def create
      resource = resource_class.new(resource_params.merge(audit_actor: current_account))

      if resource.save
        redirect_to(
          [namespace, resource],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def update
      if requested_resource.update(resource_params.merge(audit_actor: current_account))
        redirect_to(
          [namespace, requested_resource],
          notice: translate_with_resource("update.success"),
        )
      else
        render :edit, locals: {
          page: Administrate::Page::Form.new(dashboard, requested_resource),
        }
      end
    end

    # Define a custom finder by overriding the `find_resource` method:
    private def find_resource(identifier)
      Account.friendly.find(identifier)
    end

    private def permitted_attributes
      super + [:state_event]
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
