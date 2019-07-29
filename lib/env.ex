defmodule Env do
  @doc """
  lookup(env, var)

  ## Example
  iex> Env.lookup(%{a: 1, b: 2}, :a)
  1
  iex> Env.lookup(%{a: nil, b: 2}, :a)
  nil
  iex> Env.lookup(%{a: false, b: 2}, :a)
  false
  iex> Env.lookup(%{}, 'a')
  ** (RuntimeError) could not find value to variables: a
  """
  def lookup(env, var) do
    if !Map.has_key?(env, var), do: raise "could not find value to variables: #{var}"
    env[var]
  end
end
