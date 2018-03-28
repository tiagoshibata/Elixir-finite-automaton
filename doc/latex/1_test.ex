@nondeterministic_with_empty_loop [
  {:q0, :a, :q0},
  {:q0, :a, :q1},
  {:q0, :a, :q2},
  {:q0, :b, :q1},
  {:q0, nil, :q0},
  {:q0, nil, :q3},
  {:q3, nil, :q0},
  {:q3, :a, :q4},
  {:q4, :b, :q5},
]

def assert_have_same_elements(a, b) do
  assert MapSet.new(a) == MapSet.new(b)
end

test "computes next state" do
  assert_have_same_elements(
    FiniteAutomaton.next_state(:q0, :a, @nondeterministic_with_empty_loop),
    [:q0, :q1, :q2, :q4])
end
