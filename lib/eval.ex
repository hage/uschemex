defmodule Eval do
  import Uschemex.List

  @doc """
  eval(exp, env)

  exp: S-Expression
  env: Environment

  ## Example
  iex> Eval.eval([:+, 2, 3])
  5
  iex> Eval.eval([:+, [:-, 1, 2], 3])
  2
  iex> Eval.eval([:*, 5, [:+, 2, 3]])
  25
  iex> Eval.eval([:let, [[:x, 2]],
  ...> [:let, [[:fun, [:lambda, [], :x]]],
  ...> [:let, [[:x, 1]],
  ...> [:fun]]]])
  2
  iex> Eval.eval([[:lambda, [:x], [:*, :x, :x]], 4])
  16
  """
  def eval(exp), do: eval(exp, Env.global)
  def eval(exp = [:lambda|_], env), do: Lambda.eval(exp, env)
  def eval(exp = [:let|   _], env), do: Let.eval(exp, env)
  def eval(exp, env) do
    if !list?(exp) do
      if immediate_val?(exp) do
        exp
      else
        Env.lookup(env, exp)
      end
    else
      f = eval(car(exp), env)
      args = eval_list(cdr(exp), env)
      apply_it(f, args)
    end
  end

  def list?(exp) do
    is_list(exp)
  end

  def immediate_val?(exp) do
    is_number(exp)
  end

  def eval_list(exp, env) do
    Enum.map(exp, fn e -> eval(e, env) end)
  end

  def apply_it(f, args) do
    if primitive_fun?(f) do
      apply_primitive_fun(f, args)
    else
      Lambda.apply(f, args)
    end
  end

  defp primitive_fun?(exp) do
    car(exp) == :prim
  end

  defp apply_primitive_fun([:prim|f], args) do
    (car(f)).(args)
  end
end
