module Rails
  class Console
    initialize = instance_method(:initialize)

    define_method :initialize do |*args|
      if Rails.env.development? || Rails.env.test?
        actor = Account.with_role_state(:administrator).last
      else
        Rails.logger.info("Welcome! What is your email?")
        email = gets.chomp

        raise(NoConsoleAuthenticationProvidedError) if email.blank?

        actor = Account.find_by!(:email => email)
      end

      PaperTrail.request.whodunnit = actor.email
      PaperTrail.request.controller_info = {
        :group_id => SecureRandom.uuid(),
        :actor_id => actor.id
      }

      initialize.bind(self).(*args)
    end
  end
end
