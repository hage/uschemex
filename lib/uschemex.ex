defmodule Uschemex do
  import Uschemex.List

  @doc """
  eval(exp)

  exp: S-Expression

  ## Example
    iex> Uschemex.eval([:+, 2, 3])
    5
    iex> Uschemex.eval([:+, [:-, 1, 2], 3])
    2
    iex> Uschemex.eval([:*, 5, [:+, 2, 3]])
    25
  """
  def eval(exp) do
    if !list?(exp) do
      if immediate_val?(exp) do
        exp
      else
        lookup_primitive_fun(exp)
      end
    else
      f = eval(car(exp))
      args = eval_list(cdr(exp))
      uapply(f, args)
    end
  end

  def list?(exp) do
    is_list(exp)
  end

  def immediate_val?(exp) do
    is_number(exp)
  end

  defp lookup_primitive_fun(:+), do: [:prim, fn [x, y] -> x + y end]
  defp lookup_primitive_fun(:-), do: [:prim, fn [x, y] -> x - y end]
  defp lookup_primitive_fun(:*), do: [:prim, fn [x, y] -> x * y end]

  def eval_list(exp) do
    Enum.map(exp, fn e -> eval(e) end)
  end

  # uapply is first letter of uSchemEX
  def uapply(f, args) do
    apply_primitive_fun(f, args)
  end

  defp apply_primitive_fun([:prim|f], args) do
    (car(f)).(args)
  end
end
