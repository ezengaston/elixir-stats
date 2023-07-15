defmodule Stats.Variability.Range do
  alias Stats.{Errors, Validators}

  # ================================================================

  @spec range([number()]) :: number() | {atom(), String.t()}
  def range([]), do: Errors.invalid_data_type()

  def range(nums) when is_list(nums) do
    nums
    |> Validators.validate_num_list()
    |> calc_range()
  end

  def range(_), do: Errors.invalid_data_type()

  # ================================================================

  @spec calc_range({boolean(), [number()]}) :: number() | {atom(), String.t()}
  defp calc_range({false, _nums}), do: Errors.invalid_data_type()

  defp calc_range({true, nums}) do
    highest_value = Enum.max(nums)
    lowest_value = Enum.min(nums)

    highest_value - lowest_value
  end
end
