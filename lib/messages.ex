defmodule Messages do
  alias Nodes.NodeManager

  defdelegate start_link(name), to: NodeManager
end
