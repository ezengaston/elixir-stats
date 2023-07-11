defmodule Stats.CentralTendency.Mode do
  alias Stats.{Errors, Validators}

  # ================================================================

  @spec mode([number()]) :: [number()] | {atom(), String.t()}
  def mode([]), do: Errors.invalid_data_type()

  def mode(nums) when is_list(nums) do
    nums
    |> Validators.validate_num_list()
    |> calc_mode()
  end

  def mode(_), do: Errors.invalid_data_type()

  # ================================================================

  @spec calc_mode({boolean(), [number()]}) :: [number()] | {atom(), String.t()}
  defp calc_mode({false, _nums}), do: Errors.invalid_data_type()

  defp calc_mode({true, nums}) do
    ranked_map = Enum.frequencies(nums)

    ranked_map
    |> Map.values()
    |> Enum.max()
    |> get_mode(ranked_map)
  end

  # ================================================================

  @spec get_mode(number(), map()) :: [number()] | atom()
  defp get_mode(1, _nums), do: nil

  defp get_mode(max, nums) do
    Map.filter(nums, fn {_key, value} -> value === max end)
    |> Map.keys()
  end
end
