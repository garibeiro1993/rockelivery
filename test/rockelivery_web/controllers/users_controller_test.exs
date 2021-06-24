defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true
  import Rockelivery.Factory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params =
        build(:user_params)
        |> Enum.map(fn {k, v} -> {Atom.to_string(k), v} end)
        |> Enum.into(%{})

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua das bananeiras, 35",
                 "age" => 27,
                 "cpf" => "12345678901",
                 "email" => "banana@banana.com",
                 "id" => _id
               }
             } = response
    end

    test "when there is some error, returns an error", %{conn: conn} do
      params = %{"password" => "12345678901", "name" => "Gabriel Ribeiro"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "address" => ["can't be blank"],
                 "age" => ["can't be blank"],
                 "cep" => ["can't be blank"],
                 "cpf" => ["can't be blank"],
                 "email" => ["can't be blank"]
               }
             } = response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      insert(:user)
      id = "015308b6-fb04-41e0-8334-3c05a9339de2"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end

    test "when user not found, returns an error", %{conn: conn} do
      id = "015308b6-fb04-41e0-8334-3c05a9339de9"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} = response
    end

    test "when invalid uuid, returns an error", %{conn: conn} do
      id = "015308b6_Banana"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid UUID"} = response
    end
  end

  describe "show/2" do
    test "when there is a user with the given id, returns an user", %{conn: conn} do
      insert(:user)
      id = "015308b6-fb04-41e0-8334-3c05a9339de2"

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      expected_response = %{
        "user" => %{
          "address" => "Rua das bananeiras, 35",
          "age" => 27,
          "cpf" => "12345678901",
          "email" => "banana@banana.com",
          "id" => "015308b6-fb04-41e0-8334-3c05a9339de2",
          "name" => "Ronaldo Nasario"
        }
      }

      assert expected_response == response
    end

    test "when user not found, returns an error", %{conn: conn} do
      id = "015308b6-fb04-41e0-8334-3c05a9339de3"

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} = response
    end

    test "when given a invalid user, returns an error", %{conn: conn} do
      id = "015308b6-fb04"

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid UUID"} = response
    end
  end

  describe "update/2" do
    test "when there is a user with the given id, returns an user", %{conn: conn} do
      insert(:user)

      params = %{
        "id" => "015308b6-fb04-41e0-8334-3c05a9339de2",
        "name" => "Paulao",
        "password" => "123@mudar"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, params["id"], params))
        |> json_response(:ok)

      expected_response = %{
        "user" => %{
          "address" => "Rua das bananeiras, 35",
          "age" => 27,
          "cpf" => "12345678901",
          "email" => "banana@banana.com",
          "name" => "Paulao",
          "id" => "015308b6-fb04-41e0-8334-3c05a9339de2"
        }
      }

      assert expected_response == response
    end

    test "when user not found, returns an user", %{conn: conn} do
      params = %{
        "id" => "015308b6-fb04-41e0-8334-3c05a9339de4",
        "name" => "Paulao",
        "password" => "123@mudar"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, params["id"], params))
        |> json_response(:not_found)

      assert %{"message" => "User not found"} == response
    end
  end
end
