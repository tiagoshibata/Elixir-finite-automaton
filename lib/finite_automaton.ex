defmodule FiniteAutomaton do
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

  def final_states(state, [], _), do: MapSet.new [state]

  def final_states(state, [head | tail], rules) do
    MapSet.new Enum.flat_map(next_state(state, head, rules), &final_states(&1, tail, rules))
  end

  def accepts_sentence?(state, input, rules, accept_states) do
    MapSet.intersection(final_states(state, input, rules), MapSet.new accept_states)
    |> MapSet.size > 0
  end
end
