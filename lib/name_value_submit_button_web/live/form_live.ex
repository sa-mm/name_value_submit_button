defmodule NameValueSubmitButtonWeb.Live.FormLive do
  use NameValueSubmitButtonWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <form id="my-form-id" phx-submit="submit"></form>
      <button form="my-form-id" type="submit" name="save" value="send">
        Send
      </button>
      <p><%= @match %></p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, match: nil)}
  end

  def handle_event("submit", %{"save" => "send"} = params, socket) do
    IO.inspect(params)
    {:noreply, assign(socket, match: "send clause")}
  end

  def handle_event("submit", params, socket) do
    IO.inspect(params)
    {:noreply, assign(socket, match: "not send clause")}
  end
end
