defmodule BracketPush do
  defp is_opening(?(), do: true
  defp is_opening(?{), do: true
  defp is_opening(?[), do: true
  defp is_opening(_), do: false

  defp is_closing(?)), do: true
  defp is_closing(?}), do: true
  defp is_closing(?]), do: true
  defp is_closing(_), do: false

  defp brackets_match(?(, ?)), do: true
  defp brackets_match(?{, ?}), do: true
  defp brackets_match(?[, ?]), do: true
  defp brackets_match(_, _), do: false

  defp check_brackets(str, stack) do
    case str do
      # If the string is empty, it is valid if there are no unresolved open braces
      '' -> length(stack) === 0
      [hd | tail] ->
        cond do
          # If the head is an opening bracket, add it to the stack and check the rest
          is_opening(hd) -> check_brackets(tail, [hd] ++ stack)
          # If the head is a closing bracket, pop off the top of the stack
          is_closing(hd) ->
            {last_bracket, new_stack} = List.pop_at(stack, 0)
            # If the head matches, check the rest
            if brackets_match(last_bracket, hd) do
              check_brackets(tail, new_stack)
            else
              # If it doesn't, abandon ship!
              false
            end
          true -> check_brackets(tail, stack)
        end
    end
  end

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    check_brackets(to_charlist(str), [])
  end
end
