defmodule BusiApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :username, :string
    field :en_password, :string, virtual: true
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :username, :password])
    |> validate_required([:first_name, :last_name, :email, :username, :password])
    |> put_hashed_password
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{en_password: en_password}}
        ->
          put_change(changeset, :password, Bcrypt.hash_pwd_salt(en_password))
       _ ->
          changeset
    end
  end
end
