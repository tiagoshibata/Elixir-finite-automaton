test "tests sentence acceptance" do
  assert FiniteAutomaton.accepts_sentence?(:q0, [], @nondeterministic_with_empty_loop, [:q0])
  assert not FiniteAutomaton.accepts_sentence?(:q0, [], @nondeterministic_with_empty_loop, [:q1, :q2, :q3, :q4, :q5])
  assert not FiniteAutomaton.accepts_sentence?(:q0, [:b], @nondeterministic_with_empty_loop, [:q0])
  assert FiniteAutomaton.accepts_sentence?(:q0, [:b], @nondeterministic_with_empty_loop, [:q1])
  assert FiniteAutomaton.accepts_sentence?(:q0, [:a, :b], @nondeterministic_with_empty_loop, [:q1])
  assert FiniteAutomaton.accepts_sentence?(:q0, [:a, :b], @nondeterministic_with_empty_loop, [:q5])
  assert not FiniteAutomaton.accepts_sentence?(:q0, [:a, :b], @nondeterministic_with_empty_loop, [:q0, :q2, :q3, :q4])
end
