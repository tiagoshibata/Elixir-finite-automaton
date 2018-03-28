def final_states(state, [], _), do: MapSet.new [state]

def final_states(state, [head | tail], rules) do
  MapSet.new Enum.flat_map(next_state(state, head, rules), &final_states(&1, tail, rules))
end
