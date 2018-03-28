simple_grammar = [
  {:q0, :a, :q1},
  {:q0, :b, :q2},
  {:q1, :a, :q0},
]
assert FiniteAutomaton.accepts_sentence?(:q0, [:b], simple_grammar, [:q2])
assert FiniteAutomaton.accepts_sentence?(:q0, [:a, :a, :b], simple_grammar, [:q2])
assert FiniteAutomaton.accepts_sentence?(:q0, [:a, :a, :a, :a, :b], simple_grammar, [:q2])
assert not FiniteAutomaton.accepts_sentence?(:q0, [:a], simple_grammar, [:q2])
assert not FiniteAutomaton.accepts_sentence?(:q0, [:a, :b, :a], simple_grammar, [:q2])
assert not FiniteAutomaton.accepts_sentence?(:q0, [:a, :a, :b, :b], simple_grammar, [:q2])
