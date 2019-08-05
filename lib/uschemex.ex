defmodule Uschemex do
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

  defp lookup_primitive_fun(:+), do: {:prim, fn [x, y] -> x + y end}
  defp lookup_primitive_fun(:-), do: {:prim, fn [x, y] -> x - y end}
  defp lookup_primitive_fun(:*), do: {:prim, fn [x, y] -> x * y end}

  def eval_list(exp) do
    Enum.map(exp, fn e -> eval(e) end)
  end

  # uapply is first letter of uSchemEX
  def uapply(f, args) do
    apply_primitive_fun(f, args)
  end

  defp apply_primitive_fun({_, f}, args) do
    f.(args)
  end

  @doc """
  car -- Contents of the Address part of Register

  ## Examples
    iex> Uschemex.car([:a, :b, :c])
    :a
    iex> Uschemex.car([])
    nil
    iex> Uschemex.car(1)
    ** (RuntimeError) wrong type argument: listp(1)
  """
  def car([c|_]), do: c
  def car([]),    do: nil
  def car(v),     do: raise "wrong type argument: listp(#{v})"


  @doc """
  cdr -- Contents of the Decrement part of the Register

  ## Examples
    iex> Uschemex.cdr([:a, :b, :c])
    [:b, :c]
    iex> Uschemex.cdr([])
    nil
    iex> Uschemex.cdr(1)
    ** (RuntimeError) wrong type argument: listp(1)
  """
  def cdr([_|l]), do: l
  def cdr([]),    do: nil
  def cdr(v),     do: raise "wrong type argument: listp(#{v})"
end
