defmodule Stats do
  alias Stats.CentralTendency.{Mean, Median, Mode}

  defdelegate population_mean(nums), to: Mean

  defdelegate sample_mean(nums), to: Mean

  defdelegate median(nums), to: Median

  defdelegate mode(nums), to: Mode
end
