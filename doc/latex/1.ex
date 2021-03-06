def next_state(state, input, rules, already_visited \\ MapSet.new) do
  if MapSet.member?(already_visited, state) do
    []
  else
    already_visited = MapSet.put(already_visited, state)
    rules_from_state = Enum.filter(rules, &(elem(&1, 0) == state))
    (Enum.filter(rules_from_state, &elem(&1, 1) == input)
    |> Enum.map(&elem(&1, 2)))
    ++ (Enum.filter(rules_from_state, &is_nil(elem(&1, 1)))
    |> Enum.flat_map(&next_state(elem(&1, 2), input, rules, already_visited)))
  end |> MapSet.new
end
