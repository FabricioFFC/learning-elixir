defmodule ImportService.Producer do
  alias ImportService.Statistics
  alias GeolocationService.{Geolocation, Repo}

  alias NimbleCSV.RFC4180, as: CSV

  def import(file_path) do
    {_, agent} = Statistics.start_link(name: :statistics)

    File.stream!(file_path)
    |> CSV.parse_stream(skip_headers: true)
    |> import_row(agent)
  end

  defp import_row(row, agent) do
    row
    |> Stream.map(&save_row(&1, agent))
    |> Stream.run()
  end

  defp save_row(row, agent) do
    row
    |> parse_row()
    |> run_validations()
    |> handle_validations(agent)
  end

  defp parse_row(row) do
    %{
      ip_address: fetch_sanitized_row(row, 0),
      country_code: fetch_sanitized_row(row, 1),
      country: fetch_sanitized_row(row, 2),
      city: fetch_sanitized_row(row, 3),
      latitude: fetch_sanitized_row(row, 4),
      longitude: fetch_sanitized_row(row, 5),
      mystery_value: fetch_sanitized_row(row, 6)
    }
  end

  defp fetch_sanitized_row(row, position) do
    Enum.at(row, position)
    |> String.trim()
  end

  defp run_validations(geolocation) do
    Geolocation.changeset(%Geolocation{}, geolocation)
  end

  defp handle_validations(%Ecto.Changeset{valid?: true} = changeset, agent) do
    Repo.insert(changeset)
    |> handle_insert_result(agent)
  end

  defp handle_validations(%Ecto.Changeset{valid?: false}, agent) do
    Statistics.increment_discarded_count(agent)
  end

  defp handle_insert_result({:ok, _}, agent), do: Statistics.increment_accepted_count(agent)

  defp handle_insert_result({:error, _}, agent), do: Statistics.increment_discarded_count(agent)
end
