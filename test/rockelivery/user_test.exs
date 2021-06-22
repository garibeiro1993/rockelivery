defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.User

  import Rockelivery.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      response = User.changeset(build(:user_params))

      assert %Changeset{changes: %{name: "Ronaldo Nasario"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      update_params = %{
        name: "natan",
        address: "Rua das Aranhas, 55, Floripa - SC - BR",
        password: "123@Mudar"
      }

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{
               changes: %{address: "Rua das Aranhas, 55, Floripa - SC - BR", name: "natan"},
               valid?: true
             } = response
    end

    test "when there are some error, returns a invalid changeset" do
      params = build(:user_params, password: "123", age: 17)

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
