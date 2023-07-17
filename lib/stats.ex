defmodule Stats do
  alias Stats.CentralTendency.{Mean, Median, Mode}
  alias Stats.Variability.Range

  defdelegate population_mean(nums), to: Mean

  defdelegate sample_mean(nums), to: Mean

  defdelegate median(nums), to: Median

  defdelegate mode(nums), to: Mode

  defdelegate range(nums), to: Range

  defdelegate interquartile_range(nums), to: Range
end
