defmodule GeolocationServiceWeb.GeolocationControllerTest do
  use GeolocationServiceWeb.ConnCase

  alias GeolocationService.{Geolocation, Repo}

  import GeolocationService.Factory

  setup %{conn: conn} do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show" do
    test "returns a geolocation when it exists", %{conn: conn} do
      params = params_for(:geolocation)
      changeset = Geolocation.changeset(%Geolocation{}, params)

      Repo.insert!(changeset)

      conn = get(conn, "/api/geolocations/#{params[:ip_address]}")

      response_body = json_response(conn, 200)

      assert response_body == %{
               "data" => %{
                 "city" => params[:city],
                 "country" => params[:country],
                 "country_code" => params[:country_code],
                 "ip_address" => params[:ip_address],
                 "latitude" => params[:latitude],
                 "longitude" => params[:longitude],
                 "mystery_value" => params[:mystery_value]
               }
             }
    end

    test "returns a 404 when the geolocation does not exist", %{conn: conn} do
      conn = get(conn, "/api/geolocations/192.1.1.1")

      response_body = json_response(conn, 404)

      assert response_body == %{
               "errors" => %{
                 "detail" => "Not Found"
               }
             }
    end
  end
end
