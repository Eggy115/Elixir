defmodule MyProcess do
  def start do
    spawn(__MODULE__, :loop, [[]])
  end

  def loop(state) do
    receive do
      {:add, value} ->
        loop([value | state])
      {:get} ->
        IO.puts Enum.sum(state)
        loop(state)
    end
  end
end

pid = MyProcess.start()
send(pid, {:add, 1})
send(pid, {:add, 2})
send(pid, {:add, 3})
send(pid, {:get})
