defmodule InvextWeb.TicketController do
  use InvextWeb, :controller

  alias Invext.HelpDesk
  alias Invext.HelpDesk.Ticket

  action_fallback InvextWeb.FallbackController

  def index(conn, _params) do
    tickets = HelpDesk.list_tickets()
    render(conn, :index, tickets: tickets)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    with {:ok, %Ticket{} = ticket} <- HelpDesk.create_ticket(ticket_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tickets/#{ticket}")
      |> render(:show, ticket: ticket)
    end
  end

  def show(conn, %{"id" => id}) do
    ticket = HelpDesk.get_ticket!(id)
    render(conn, :show, ticket: ticket)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = HelpDesk.get_ticket!(id)

    with {:ok, %Ticket{} = ticket} <- HelpDesk.update_ticket(ticket, ticket_params) do
      render(conn, :show, ticket: ticket)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticket = HelpDesk.get_ticket!(id)

    with {:ok, %Ticket{}} <- HelpDesk.delete_ticket(ticket) do
      send_resp(conn, :no_content, "")
    end
  end
end
