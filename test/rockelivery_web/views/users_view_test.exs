defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %Rockelivery.User{
               address: "Rua das bananeiras, 35",
               age: 27,
               cep: "89898989",
               cpf: "12345678901",
               email: "banana@banana.com",
               id: "015308b6-fb04-41e0-8334-3c05a9339de2",
               inserted_at: nil,
               name: "Ronaldo Nasario",
               password: "123@Mudar",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end
