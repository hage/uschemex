defmodule Uschemex.List do
  @doc """
  car -- Contents of the Address part of Register

  ## Examples
  iex> Uschemex.List.car([:a, :b, :c])
  :a
  iex> Uschemex.List.car([])
  nil
  iex> Uschemex.List.car(1)
  ** (RuntimeError) wrong type argument: listp(1)
  """
  def car([c|_]), do: c
  def car([]),    do: nil
  def car(v),     do: raise "wrong type argument: listp(#{v})"

  @doc """
  cdr -- Contents of the Decrement part of the Register

  ## Examples
  iex> Uschemex.List.cdr([:a, :b, :c])
  [:b, :c]
  iex> Uschemex.List.cdr([])
  nil
  iex> Uschemex.List.cdr(1)
  ** (RuntimeError) wrong type argument: listp(1)
  """
  def cdr([_|l]), do: l
  def cdr([]),    do: nil
  def cdr(v),     do: raise "wrong type argument: listp(#{v})"
end
