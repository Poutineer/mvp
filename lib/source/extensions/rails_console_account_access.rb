module RailsConsoleAccountAccess
  def initialize(*arguments)
    unless ActiveRecord::Base.connected? && Account.exists?
      PaperTrail.request.whodunnit = Account::MACHINE_EMAIL
      PaperTrail.request.controller_info = {
        :context_id => SecureRandom.uuid(),
        :actor_id => Account::MACHINE_ID,
      }

      return super(*arguments)
    end

    if Account.exists? && Rails.env.production?
      Rails.logger.info("Welcome! What is your email?")

      email = gets.chomp

      raise(StandardError, "no email provided") if email.blank?

      actor = Account.find_by(:email => email)

      raise(StandardError, "incorrect or bad email") if actor.blank?

      Rails.logger.info("What is your password?")

      password = gets.chomp

      raise(StandardError, "incorrect or bad password") unless Devise.secure_compare(actor.encrypted_password, password)

      PaperTrail.request.whodunnit = actor.email
      PaperTrail.request.controller_info = {
        :context_id => SecureRandom.uuid(),
        :actor_id => actor.id,
      }

      return super(*arguments)
    end

    super(*arguments)
  end
end

Rails::Console.prepend(RailsConsoleAccountAccess) if Rails.const_defined?("Console")
