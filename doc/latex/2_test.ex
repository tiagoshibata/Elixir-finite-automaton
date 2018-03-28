test "computes final state" do
  assert_have_same_elements(
    FiniteAutomaton.final_states(:q0, [:b], @nondeterministic_with_empty_loop),
    [:q1])
  assert_have_same_elements(
    FiniteAutomaton.final_states(:q0, [:a, :b], @nondeterministic_with_empty_loop),
    [:q1, :q5])
end
