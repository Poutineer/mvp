class CreateEstablishments < ActiveRecord::Migration[5.2]
  def change
    create_table(:establishments) do |table|
      table.text(:name, :null => false)
      table.citext(:slug, :null => false)
      table.text(:google_places_id)
      table.jsonb(:google_place, :null => false, :default => {})
      table.citext(:moderation_state, :null => false)
      table.timestamps

      table.index(:slug)
      table.index(:moderation_state)
      table.index(:google_places_id)
    end
  end
end
