defmodule Invext.HelpDeskTest do
  use Invext.DataCase

  alias Invext.HelpDesk

  describe "tickets" do
    alias Invext.HelpDesk.Ticket

    import Invext.HelpDeskFixtures

    @invalid_attrs %{description: nil, status: nil, title: nil, type: nil}

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert HelpDesk.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert HelpDesk.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      valid_attrs = %{description: "some description", status: :queued, title: "some title", type: :cards}

      assert {:ok, %Ticket{} = ticket} = HelpDesk.create_ticket(valid_attrs)
      assert ticket.description == "some description"
      assert ticket.status == :queued
      assert ticket.title == "some title"
      assert ticket.type == :cards
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HelpDesk.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      update_attrs = %{description: "some updated description", status: :solving, title: "some updated title", type: :loans}

      assert {:ok, %Ticket{} = ticket} = HelpDesk.update_ticket(ticket, update_attrs)
      assert ticket.description == "some updated description"
      assert ticket.status == :solving
      assert ticket.title == "some updated title"
      assert ticket.type == :loans
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = HelpDesk.update_ticket(ticket, @invalid_attrs)
      assert ticket == HelpDesk.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = HelpDesk.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> HelpDesk.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = HelpDesk.change_ticket(ticket)
    end
  end
end
