defmodule Invext.Repo.Migrations.AddStaffIdToTickets do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      add :staff_id, references(:staffs)
    end
  end
end
