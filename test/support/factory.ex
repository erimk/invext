defmodule Invext.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Invext.Repo

  def staff_factory do
    %Invext.HelpDesk.Staff{
      name: "My awesome article!",
      team: :cards
    }
  end

  def ticket_factory do
    %Invext.HelpDesk.Ticket{
      description: "some description",
      status: :queued,
      title: "some title",
      type: :cards
    }
  end
end
