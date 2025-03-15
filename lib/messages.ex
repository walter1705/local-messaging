defmodule Messages do
  alias Nodes.Node_Manager

  defdelegate start_link(name), to: Node_Manager
end
