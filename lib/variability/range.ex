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

  @spec interquartile_range([number()]) :: number() | {atom(), String.t()}
  def interquartile_range([]), do: Errors.invalid_data_type()

  def interquartile_range(nums) when is_list(nums) do
    nums
    |> Validators.validate_num_list()
    |> calc_quartile()
    |> calc_range()
  end

  def interquartile_range(_), do: Errors.invalid_data_type()

  # ================================================================

  @spec calc_range({boolean(), [number()]}) :: number() | {atom(), String.t()}
  defp calc_range({false, _nums}), do: Errors.invalid_data_type()

  defp calc_range({true, nums}) do
    highest_value = Enum.max(nums)
    lowest_value = Enum.min(nums)

    highest_value - lowest_value
  end

  @spec calc_quartile({boolean(), [number()]}) :: [number()] | {atom(), String.t()}
  def calc_quartile({false, _nums}), do: Errors.invalid_data_type()

  def calc_quartile({true, nums}) do
    list_count = length(nums)

    percent_25 =
      (list_count * 0.25)
      |> Float.floor()
      |> trunc()

    percent_75 =
      (list_count * 0.75)
      |> Float.floor()
      |> trunc()

    sorted = Enum.sort(nums)

    {true, [Enum.at(sorted, percent_25 - 1), Enum.at(sorted, percent_75 - 1)]}
  end
end
