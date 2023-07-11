defmodule Stats.CentralTendency.Median do
  require Integer
  alias Stats.{Errors, Validators}

  # ================================================================

  @spec median([number()]) :: number() | {:atom, String.t()}
  def median(nums) when is_list(nums) do
    nums
    |> Validators.validate_num_list()
    |> calc_median()
  end

  def median(_nums), do: Errors.invalid_data_type()

  # ================================================================

  @spec calc_median({boolean(), [number()]}) :: number() | {:atom, String.t()}
  defp calc_median({false, _nums}), do: Errors.invalid_data_type()

  defp calc_median({true, nums}) do
    count = Enum.count(nums)

    nums
    |> Enum.sort()
    |> get_median(Integer.is_even(count), count)
  end

  # ================================================================

  @spec get_median([number()], boolean(), integer()) :: number()
  defp get_median(nums, false, count), do: Enum.at(nums, div(count, 2))

  defp get_median(nums, true, count) do
    a = Enum.at(nums, div(count - 1, 2))
    b = Enum.at(nums, div(count, 2))

    (a + b) / 2
  end
end
