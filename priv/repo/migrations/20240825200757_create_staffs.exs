defmodule Invext.Repo.Migrations.CreateStaffs do
  use Ecto.Migration

  def change do
    create table(:staffs) do
      add :name, :string
      add :team, :string

      timestamps(type: :utc_datetime)
    end
  end
end
