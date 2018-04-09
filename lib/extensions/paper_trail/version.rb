class PaperTrail::Version < ::ActiveRecord::Base
  belongs_to :actor, class_name: "Account"
  belongs_to :item, polymorphic: true

  def actor
    super || ActorNull.new(name: whodunnit, username: whodunnit)
  end
end