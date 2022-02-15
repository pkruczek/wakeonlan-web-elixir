defmodule WolWeb.ComputerLive do
  use WolWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    address = machine_address()

    if connected?(socket) do
      register_pinger_server(address)
      subscribe_state_change(address)
    end

    {:ok, assign(socket, enabled: machine_enabled?(address), machine_address: machine_address)}
  end

  @impl true
  def handle_event("start", _, socket) do
    machine_start_address()
    |> start_machine()

    {:noreply, socket}
  end

  @impl true
  def handle_info({:state_changed, new_state}, socket) do
    {:noreply, assign(socket, :enabled, new_state)}
  end

  defp register_pinger_server(address) do
    pid = Machine.Pinger.Cache.server_process(address)
    Machine.Pinger.Server.subscribe(pid)

    Machine.Pinger.Server.register_callback(
      pid,
      fn state ->
        broadcast_state_change(address, state)
      end
    )
  end

  defp machine_enabled?(machine_address) do
    Machine.Pinger.Cache.server_process(machine_address)
    |> Machine.Pinger.Server.enabled?()
  end

  defp start_machine(machine_start_address) do
    Machine.Starter.Cache.server_process(machine_start_address)
    |> Machine.Starter.Server.start_machine()
  end

  defp broadcast_state_change(address, state) do
    Phoenix.PubSub.broadcast(Wol.PubSub, "machine.state:#{address}", {:state_changed, state})
  end

  defp subscribe_state_change(address) do
    Phoenix.PubSub.subscribe(Wol.PubSub, "machine.state:#{address}")
  end

  defp machine_address do
    Application.get_env(:wol, :machine_ip, "172.16.12.1")
  end

  defp machine_start_address do
    {
      Application.get_env(:wol, :machine_mac, "ca:fe:ba:be:cc:cc"),
      Application.get_env(:wol, :machine_network_broadcast, "172.16.10.255")
    }
  end
end
