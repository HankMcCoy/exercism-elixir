defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
      |> to_charlist
      |> Enum.map(rotate_char(shift))
      |> to_string
  end

  defp rotate_char(shift) do
    fn char ->
      cond do
        # Handle capital letters
        char >= ?A && char <= ?Z ->
          rem(char - ?A + shift, 26) + ?A
        # Handle lower-case letters
        char >= ?a && char <= ?z ->
          rem(char - ?a + shift, 26) + ?a
        # Pass other characters straight through
        true -> char
      end
    end
  end
end
