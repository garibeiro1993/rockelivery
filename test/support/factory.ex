defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo
  alias Rockelivery.User

  def user_params_factory do
    %{
      age: 27,
      address: "Rua das bananeiras, 35",
      cep: "89898989",
      cpf: "12345678901",
      email: "banana@banana.com",
      password: "123@Mudar",
      name: "Ronaldo Nasario"
    }
  end

  def user_factory do
    %User{
      age: 27,
      address: "Rua das bananeiras, 35",
      cep: "89898989",
      cpf: "12345678901",
      email: "banana@banana.com",
      password: "123@Mudar",
      name: "Ronaldo Nasario",
      id: "015308b6-fb04-41e0-8334-3c05a9339de2"
    }
  end
end
