defmodule Poutineer.Models.MenuItemDiet do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menu_item_diets" do
    belongs_to :menu_item, Poutineer.Models.MenuItem
    belongs_to :diet, Poutineer.Models.Diet

    timestamps()
  end
end