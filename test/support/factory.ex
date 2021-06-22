defmodule Rockelivery.Factory do
  use ExMachina

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
end
