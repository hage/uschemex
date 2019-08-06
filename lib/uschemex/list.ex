defmodule Uschemex.List do
  @doc """
  car -- Contents of the Address part of Register

  ## Examples
  iex> Uschemex.List.car([:a, :b, :c])
  :a
  iex> Uschemex.List.car([])
  nil
  iex> Uschemex.List.car(Array)
  ** (RuntimeError) wrong type argument: listp(Array)
  """
  def car([c|_]), do: c
  def car([]),    do: nil
  def car(v),     do: raise "wrong type argument: listp(#{inspect v})"

  @doc """
  cdr -- Contents of the Decrement part of the Register

  ## Examples
  iex> Uschemex.List.cdr([:a, :b, :c])
  [:b, :c]
  iex> Uschemex.List.cdr([])
  nil
  iex> Uschemex.List.cdr(%{})
  ** (RuntimeError) wrong type argument: listp(%{})
  """
  def cdr([_|l]), do: l
  def cdr([]),    do: nil
  def cdr(v),     do: raise "wrong type argument: listp(#{inspect v})"
end
