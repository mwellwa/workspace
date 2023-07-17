defmodule Workspace.ClientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Workspace.Clients` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        country: "some country",
        email: "some email",
        name: "some name",
        phone_number: "some phone_number",
        sector: "some sector"
      })
      |> Workspace.Clients.create_client()

    client
  end
end
