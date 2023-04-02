defmodule MyServer do
  use GenServer

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:set, value}, _from, _state) do
    {:reply, :ok, value}
  end
end

{:ok, pid} = MyServer.start_link("initial state")
{:ok, new_state} = GenServer.call(pid, {:set, "new state"})
IO.puts new_state
