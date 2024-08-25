defmodule Invext.HelpDeskFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Invext.HelpDesk` context.
  """

  @doc """
  Generate a ticket.
  """
  def ticket_fixture(attrs \\ %{}) do
    {:ok, ticket} =
      attrs
      |> Enum.into(%{
        description: "some description",
        status: :queued,
        title: "some title",
        type: :cards
      })
      |> Invext.HelpDesk.create_ticket()

    ticket
  end

  @doc """
  Generate a staff.
  """
  def staff_fixture(attrs \\ %{}) do
    {:ok, staff} =
      attrs
      |> Enum.into(%{
        name: "some name",
        team: :cards
      })
      |> Invext.HelpDesk.create_staff()

    staff
  end
end
