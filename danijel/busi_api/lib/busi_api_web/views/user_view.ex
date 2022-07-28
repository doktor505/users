defmodule BusiApiWeb.UserView do
  use BusiApiWeb, :view

  def render("user.json", %{user: user, token: token}) do
    %{
      username: user.username,
      token: token
    }
    #%{data: render_many(users, UserView, "user.json")}
  end

end
