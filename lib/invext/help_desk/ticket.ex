defmodule Invext.HelpDesk.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :description, :string
    field :status, Ecto.Enum, values: [:queued, :solving, :finished], default: :queued
    field :title, :string
    field :type, Ecto.Enum, values: [:cards, :loans, :others]

    belongs_to :staff, Invext.HelpDesk.Staff

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:title, :description, :type])
    |> validate_required([:title, :description, :type])
  end

  def update_changeset(ticket, attrs, staff) do
    ticket
    |> cast(attrs, [:title, :description, :type, :status])
    |> put_assoc(:staff, staff)
    |> validate_required([:title, :description, :type, :status])
  end
end
