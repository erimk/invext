defmodule InvextWeb.TicketControllerTest do
  use InvextWeb.ConnCase

  import Invext.Factory

  alias Invext.HelpDesk.Ticket

  @create_attrs %{
    description: "some description",
    title: "some title",
    type: :cards
  }

  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    type: :loans
  }

  @invalid_attrs %{description: nil, status: nil, title: nil, type: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tickets", %{conn: conn} do
      conn = get(conn, ~p"/api/tickets")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create" do
    test "renders ticket when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/tickets", ticket: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/tickets/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "status" => "queued",
               "title" => "some title",
               "type" => "cards"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/tickets", ticket: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update" do
    setup [:create_ticket]

    test "renders ticket when data is valid", %{conn: conn, ticket: %Ticket{id: id} = ticket} do
      conn = put(conn, ~p"/api/tickets/#{ticket}", ticket: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/tickets/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "status" => "queued",
               "title" => "some updated title",
               "type" => "loans"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, ticket: ticket} do
      conn = put(conn, ~p"/api/tickets/#{ticket}", ticket: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete" do
    setup [:create_ticket]

    test "deletes chosen ticket", %{conn: conn, ticket: ticket} do
      conn = delete(conn, ~p"/api/tickets/#{ticket}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/tickets/#{ticket}")
      end
    end
  end

  describe "take" do
    test "renders ok when valid data", %{conn: conn} do
      ticket = insert(:ticket)
      staff = insert(:staff, %{team: ticket.type})
      params = %{staff_id: staff.id}

      conn = post(conn, ~p"/api/tickets/take", params)

      assert subject = json_response(conn, 200)["data"]
      assert subject["id"] == ticket.id
      assert subject["staff_id"] == staff.id
      assert subject["status"] == "solving"
    end

    test "renders error when staff differs team", %{conn: conn} do
      insert(:ticket)
      staff = insert(:staff, %{team: :loans})
      params = %{staff_id: staff.id}

      conn = post(conn, ~p"/api/tickets/take", params)

      assert %{"detail" => "Not Found"} = json_response(conn, 404)["errors"]
    end

    test "renders error when ticket is already finished", %{conn: conn} do
      ticket = insert(:ticket, %{status: :finished})
      staff = insert(:staff, %{team: ticket.type})
      params = %{staff_id: staff.id}

      conn = post(conn, ~p"/api/tickets/take", params)

      assert json_response(conn, 404)
    end
  end

  defp create_ticket(_) do
    ticket = insert(:ticket)
    %{ticket: ticket}
  end
end
