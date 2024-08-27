defmodule Invext.HelpDeskTest do
  use Invext.DataCase

  import Invext.Factory

  alias Invext.HelpDesk

  describe "tickets" do
    alias Invext.HelpDesk.Ticket

    @invalid_attrs %{description: nil, status: nil, title: nil, type: nil}

    test "list_tickets/0 returns all tickets" do
      ticket = insert(:ticket)
      assert HelpDesk.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = insert(:ticket)
      assert HelpDesk.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      valid_attrs = %{
        description: "some description",
        status: :queued,
        title: "some title",
        type: :cards
      }

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
      ticket = insert(:ticket)

      update_attrs = %{
        description: "some updated description",
        status: :solving,
        title: "some updated title",
        type: :loans
      }

      assert {:ok, %Ticket{} = ticket} = HelpDesk.update_ticket(ticket, update_attrs)
      assert ticket.description == "some updated description"
      assert ticket.status == :queued
      assert ticket.title == "some updated title"
      assert ticket.type == :loans
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = insert(:ticket)
      assert {:error, %Ecto.Changeset{}} = HelpDesk.update_ticket(ticket, @invalid_attrs)
      assert ticket == HelpDesk.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = insert(:ticket)
      assert {:ok, %Ticket{}} = HelpDesk.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> HelpDesk.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = insert(:ticket)
      assert %Ecto.Changeset{} = HelpDesk.change_ticket(ticket)
    end
  end

  describe "staffs" do
    alias Invext.HelpDesk.Staff

    @invalid_attrs %{name: nil, team: nil}

    test "list_staffs/0 returns all staffs" do
      staff = insert(:staff)
      assert HelpDesk.list_staffs() == [staff]
    end

    test "get_staff!/1 returns the staff with given id" do
      staff = insert(:staff)
      assert HelpDesk.get_staff!(staff.id) == staff
    end

    test "create_staff/1 with valid data creates a staff" do
      valid_attrs = %{name: "some name", team: :cards}

      assert {:ok, %Staff{} = staff} = HelpDesk.create_staff(valid_attrs)
      assert staff.name == "some name"
      assert staff.team == :cards
    end

    test "create_staff/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HelpDesk.create_staff(@invalid_attrs)
    end

    test "update_staff/2 with valid data updates the staff" do
      staff = insert(:staff)
      update_attrs = %{name: "some updated name", team: :loans}

      assert {:ok, %Staff{} = staff} = HelpDesk.update_staff(staff, update_attrs)
      assert staff.name == "some updated name"
      assert staff.team == :loans
    end

    test "update_staff/2 with invalid data returns error changeset" do
      staff = insert(:staff)
      assert {:error, %Ecto.Changeset{}} = HelpDesk.update_staff(staff, @invalid_attrs)
      assert staff == HelpDesk.get_staff!(staff.id)
    end

    test "delete_staff/1 deletes the staff" do
      staff = insert(:staff)
      assert {:ok, %Staff{}} = HelpDesk.delete_staff(staff)
      assert_raise Ecto.NoResultsError, fn -> HelpDesk.get_staff!(staff.id) end
    end

    test "change_staff/1 returns a staff changeset" do
      staff = insert(:staff)
      assert %Ecto.Changeset{} = HelpDesk.change_staff(staff)
    end
  end
end
