defmodule Poutineer.Resolvers.Establishments do
  alias Poutineer.Repo
  alias Poutineer.Models.Establishment

  def list(_parent, _arguments, _resolution) do
    {:ok, Repo.all(Establishment)}
  end

  def fetch(_parent, arguments, _resolution) do
    {:ok, Repo.get(Establishment, arguments[:id])}
  end

  # def create(_parent, arguments, _resolution) do
  #   password = :crypto.strong_rand_bytes(24)
  #     |> Base.encode32(case: :upper)
  #     |> binary_part(0, 24)
  #
  #   Establishment.changeset(%Establishment{}, Map.merge(%{password: password, confirm_password: password}, arguments))
  #     |> case do
  #       %Ecto.Changeset{valid?: true} = changeset -> Repo.insert(changeset)
  #       %Ecto.Changeset{valid?: false} = changeset -> {:error, changeset}
  #     end
  # end
end
