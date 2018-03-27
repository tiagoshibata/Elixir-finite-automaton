defmodule FiniteAutomationTest do
  use ExUnit.Case
  doctest FiniteAutomation

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
      FiniteAutomation.next_state(:q0, :a, @nondeterministic_with_empty_loop),
      [:q0, :q1, :q2, :q4])
  end

  test "computes final state" do
    assert_have_same_elements(
      FiniteAutomation.final_states(:q0, [:b], @nondeterministic_with_empty_loop),
      [:q1])
    assert_have_same_elements(
      FiniteAutomation.final_states(:q0, [:a, :b], @nondeterministic_with_empty_loop),
      [:q1, :q5])
  end

  test "tests sentence acceptance" do
    assert not FiniteAutomation.accepts_sentence?(:q0, [:b], @nondeterministic_with_empty_loop, [:q0])
    assert FiniteAutomation.accepts_sentence?(:q0, [:b], @nondeterministic_with_empty_loop, [:q1])
    assert FiniteAutomation.accepts_sentence?(:q0, [:a, :b], @nondeterministic_with_empty_loop, [:q1])
    assert FiniteAutomation.accepts_sentence?(:q0, [:a, :b], @nondeterministic_with_empty_loop, [:q5])
    assert not FiniteAutomation.accepts_sentence?(:q0, [:a, :b], @nondeterministic_with_empty_loop, [:q0, :q2, :q3, :q4])
  end
end
