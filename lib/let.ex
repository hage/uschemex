defmodule Let do
  import Uschemex.List

  @doc """
  Let.eval/2

  ## Example
  iex> Let.eval([:let, [[:x, 3], [:y, 2]], [:lambda, [:x, :y], [:*, :x, :y]]], %{})
  [:closure, [:x, :y], [:*, :x, :y], %{x: 3, y: 2}]
  """
  def eval(exp, env) do
    Eval.eval(translate_let_to_lambda(exp), env)
  end

  def let?(exp) do
    :let == car(exp)
  end

  @doc """
  Let.translate_let_to_lambda([:let,bind, body])

  ## Example
  iex> Let.translate_let_to_lambda([:let, [[:x, 1], [:y, 2]], [:+, :x, :y]])
  [[:lambda, [:x, :y], [:+, :x, :y]], 1, 2]
  """
  def translate_let_to_lambda([:let, bind, body]) do
    [[:lambda, extract_vars(bind), body]] ++ extract_vals(bind)
  end

  @doc """
  Let.extract_vars

  ## Example
  iex> Let.extract_vars([[:x, 1], [:y, 2]])
  [:x, :y]
  """
  def extract_vars(bind) do
    bind
    |> Enum.map(fn e -> car(e) end)
  end

  @doc """
  Let.extract_vals

  ## Example
  iex> Let.extract_vals([[:x, 1], [:y, 2]])
  [1, 2]
  """
  def extract_vals(bind) do
    bind
    |> Enum.map(fn e -> car(cdr(e)) end)
  end
end
