module Rails
  class Console
    initialize = instance_method(:initialize)

    define_method :initialize do |*args|
      unless Rails.env.development? || Rails.env.test?
        puts "Welcome! What is your email?"
        email = gets.chomp

        raise NoConsoleAuthenticationProvidedError unless email.present?

        actor = Account.find_by!(email: email)

        PaperTrail.request.whodunnit = actor
        PaperTrail.request.controller_info = {
          actor_id: actor,
          group_id: SecureRandom.uuid,
        }
      end

      initialize.bind(self).call(*args)
    end
  end
end
