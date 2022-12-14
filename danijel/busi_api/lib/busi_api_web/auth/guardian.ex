
defmodule BusiApiWeb.Auth.Guardian do
  use Guardian, otp_app: :busi_api

  alias BusiApi.Accounts

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Accounts.get_user!(id)
    {:ok,  resource}
  end

  def authenticate(username, en_password) do
    with {:ok, user} <- Accounts.get_by_username(username) do
      case validate_password(en_password, user.password) do
        true ->
          create_token(user)
        false ->
          {:error, :unauthorized}
      end
    end
  end

  defp validate_password(en_password, password) do
    Bcrypt.verify_pass(en_password, password)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
  
end