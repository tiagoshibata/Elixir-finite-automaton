defmodule FiniteAutomatonTest do
  use ExUnit.Case
  doctest FiniteAutomaton

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

  test "computes final state" do
    assert_have_same_elements(
      FiniteAutomaton.final_states(:q0, [:b], @nondeterministic_with_empty_loop),
      [:q1])
    assert_have_same_elements(
      FiniteAutomaton.final_states(:q0, [:a, :b], @nondeterministic_with_empty_loop),
      [:q1, :q5])
  end

  test "tests sentence acceptance" do
    assert FiniteAutomaton.accepts_sentence?(:q0, [], @nondeterministic_with_empty_loop, [:q0])
    assert not FiniteAutomaton.accepts_sentence?(:q0, [], @nondeterministic_with_empty_loop, [:q1, :q2, :q3, :q4, :q5])

    assert not FiniteAutomaton.accepts_sentence?(:q0, [:b], @nondeterministic_with_empty_loop, [:q0])
    assert FiniteAutomaton.accepts_sentence?(:q0, [:b], @nondeterministic_with_empty_loop, [:q1])

    assert FiniteAutomaton.accepts_sentence?(:q0, [:a, :b], @nondeterministic_with_empty_loop, [:q1])
    assert FiniteAutomaton.accepts_sentence?(:q0, [:a, :b], @nondeterministic_with_empty_loop, [:q5])
    assert not FiniteAutomaton.accepts_sentence?(:q0, [:a, :b], @nondeterministic_with_empty_loop, [:q0, :q2, :q3, :q4])

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
  end
end
