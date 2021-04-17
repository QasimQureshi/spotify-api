defmodule SpotifyapiWeb.PageLive do
  use SpotifyapiWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def handle_event("suggest", %{"q" => query}, socket) do
    {:noreply, assign(socket, results: search(query), query: query)}
  end

  @impl true
  def handle_event("search", %{"q" => query}, socket) do
    case search(query) do
      # params = [access_token: "2"]
      # %{
      #   "q" => query,
      # } = response
      
      # url = "https://api.spotify.com/v1/artists"
      # url = "https://api.spotify.com/v1/search"
      

      # {:ok, response} <- HTTPoison.get(url, headers, params: params)
      # Poison.decode(response.body)
        # "BQCzsUez9Xv26VNl0l5hWOEiAfM1Jh4tBo7SzMoSpE0kviUI4k9MvXdR_n8PhgDH3XaTrjY6GUBG-kk_vXs
      %{^query => vsn} ->
        {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}
        # {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}
        # https://api.spotify.com/v1/search

      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "No dependencies found matching \"#{query}\"")
         |> assign(results: %{}, query: query)}
    end
  end

  defp search(query) do
    if not SpotifyapiWeb.Endpoint.config(:code_reloader) do
      raise "action disabled when not in development"
    end

    for {app, desc, vsn} <- Application.started_applications(),
        app = to_string(app),
        String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
        into: %{},
        do: {app, vsn}
  end
end
