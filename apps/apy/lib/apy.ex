defmodule APY do
  @moduledoc """
  Documentation for `APY`.
  """

  def scanData do
    "https://apilist.tronscan.org/api/vote/witness"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Poison.decode!()
    |> Map.get("data")
  end

  @doc """
  Return that higher apy SR

  ## Examples

      iex> APY.maxApy(%{"annualizedRate" => 1.02}, %{"annualizedRate" => 2.01})
      %{"annualizedRate" => 2.01}

  """
  def maxApy(max, sr) do
    if Map.get(sr, "annualizedRate") > Map.get(max, "annualizedRate"), do: sr, else: max
  end

  @doc """
  Return that highest annualizedRate SR among the list of SRs

  ## Examples

      iex> APY.findHighestApy([
      ...>   %{"annualizedRate" => 1.02},
      ...>   %{"annualizedRate" => 2.01},
      ...>   %{"annualizedRate" => 2.0},
      ...> ])
      %{"annualizedRate" => 2.01}
  """
  def findHighestApy(list) do
    Enum.reduce(list, &maxApy/2)
  end

  def scanHighest do
    scanData()
    |> findHighestApy
  end
end
