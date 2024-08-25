defmodule Invext.HelpDesk.Staff do
  use Ecto.Schema
  import Ecto.Changeset

  schema "staffs" do
    field :name, :string
    field :team, Ecto.Enum, values: [:cards, :loans, :others]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(staff, attrs) do
    staff
    |> cast(attrs, [:name, :team])
    |> validate_required([:name, :team])
  end
end
