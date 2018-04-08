class Allergy < ApplicationRecord
  has_and_belongs_to_many :menu_items

  has_paper_trail meta: {
    actor_id: :actor_id
  }

  validates_presence_of :name
end