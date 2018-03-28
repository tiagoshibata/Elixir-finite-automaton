def accepts_sentence?(state, input, rules, accept_states) do
  MapSet.intersection(final_states(state, input, rules), MapSet.new accept_states)
  |> MapSet.size > 0
end
