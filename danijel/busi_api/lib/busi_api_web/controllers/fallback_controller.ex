defmodule BusiApiWeb.FallbackController do

  use BusiApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BusiApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end


  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BusiApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(BusiApiWeb.ErrorView, :"401")
  end
end
