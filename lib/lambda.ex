defmodule Lambda do
  import Uschemex.List

  def eval(exp, env) do
    make_closure(exp, env)
  end

  @doc """
  Lambda.make_closure/2

  ## Example
  iex> Lambda.make_closure([:lambda, [:x], [:+, :x, :x]], %{x: 1})
  [:closure, [:x], [:+, :x, :x], %{x: 1}]
  """
  def make_closure([:lambda, vars, body], env) do
    [:closure, vars, body, env]
  end

  def lambda?(exp) do
    car(exp) == :lambda
  end

  # @doc """
  # Lambda.apply/2

  # ## Example
  # iex> Lambda.apply([:closure, [:x, :y], [:+, :x, :y], %{y: 3}], [10, 20])
  # 30
  # """
  def apply([:closure, vars, body, env], vals) do
    nenv = Env.extend(env, vars, vals)
    Eval.eval(body, nenv)
  end
end
