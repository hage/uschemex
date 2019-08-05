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

  @doc """
  extend(env, vars, vals)

  ## Example
  iex> Env.extend(%{a: 1, b: 2}, [:a], [5])
  %{a: 5, b: 2}
  """
  def extend(env, vars, vals) do
    nenv = [vars, vals]
    |> List.zip
    |> Map.new
    Map.merge(env, nenv)
  end
end
