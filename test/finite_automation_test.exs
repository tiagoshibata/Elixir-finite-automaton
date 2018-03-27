defmodule FiniteAutomationTest do
  use ExUnit.Case
  doctest FiniteAutomation

  def assert_have_same_elements(a, b) do
    assert MapSet.new(a) == MapSet.new(b)
  end

  test "computes next state" do
    rules = [
      {:q0, :a, :q1},
      {:q0, :a, :q2},
      {:q0, nil, :q3},
      {:q3, nil, :q0},
      {:q3, :a, :q4},
    ]
    assert_have_same_elements(FiniteAutomation.next_state(:q0, :a, rules),
    [:q1, :q2, :q4])
  end
end
