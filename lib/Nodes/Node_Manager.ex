defmodule Nodes.NodeManager do
  use GenServer

  @doc """
  Return a proccess ({:ok, pid}) if not error.
  Name the process with a name in the argument.
  """
  @spec start_link(String.t()) :: {:ok, pid()}
  def start_link(name) do
    GenServer.start_link(__MODULE__, name, [name: String.to_atom(name)])
  end

  @doc """
  receive the name from the star_link function
  and declare the state of the process, with the
  data we'll need in future.
  """
  @spec init(String.t()) :: {:ok, map()}
  @impl true
  def init(name) do
    pid = self()
    init_state = %{name: name, data: [], created_at: DateTime.utc_now(), pid: pid}
    IO.puts("Nodo #{name} iniciado correctamente. Con PID: #{inspect(pid)}")
    {:ok, init_state}
  end

  @impl true
  def handle_call(message, from, state) do
    {pid, _tag} = from
    response = "Mensaje recibido: '#{message}' de: #{inspect(pid)}." |> IO.puts()
    {:reply, response, state}
  end

  @impl true
  def handle_cast(request, state) do
    IO.puts("#{inspect(self())} mensaje recibido: '#{request}'.")
    {:noreply, state}
  end

  @spec call(any(), atom() | pid() | {atom(), any()} | {:via, atom(), any()}) :: :ok
  def call(message, pid) do
    IO.puts("Se envio el mensaje: '#{message}' a #{inspect(pid)}.")
    GenServer.call(pid, message)
  end

  def cast(server, message) do
    IO.puts("Se envio el mensaje: '#{message}' a #{inspect(server)}.")
    GenServer.cast(server, message)
  end
end
