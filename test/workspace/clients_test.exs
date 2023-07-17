defmodule Workspace.ClientsTest do
  use Workspace.DataCase

  alias Workspace.Clients

  describe "clients" do
    alias Workspace.Clients.Client

    import Workspace.ClientsFixtures

    @invalid_attrs %{country: nil, email: nil, name: nil, phone_number: nil, sector: nil}

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Clients.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Clients.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{country: "some country", email: "some email", name: "some name", phone_number: "some phone_number", sector: "some sector"}

      assert {:ok, %Client{} = client} = Clients.create_client(valid_attrs)
      assert client.country == "some country"
      assert client.email == "some email"
      assert client.name == "some name"
      assert client.phone_number == "some phone_number"
      assert client.sector == "some sector"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clients.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      update_attrs = %{country: "some updated country", email: "some updated email", name: "some updated name", phone_number: "some updated phone_number", sector: "some updated sector"}

      assert {:ok, %Client{} = client} = Clients.update_client(client, update_attrs)
      assert client.country == "some updated country"
      assert client.email == "some updated email"
      assert client.name == "some updated name"
      assert client.phone_number == "some updated phone_number"
      assert client.sector == "some updated sector"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.update_client(client, @invalid_attrs)
      assert client == Clients.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Clients.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Clients.change_client(client)
    end
  end
end
