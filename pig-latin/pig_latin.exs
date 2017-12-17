defmodule PigLatin do
  @vowels ~w(a e i o u xr yt)c
  @consonants ~w(b ch c d f g h j k l m n p qu q r s t v w x y z)c

  defp translate_word(word) do
    re_get_start_and_rest = Regex.compile!(~s/^((?:#{Enum.join(@consonants, "|")})+)?(.*)/)
    re_starts_with_vowel = Regex.compile!(~s/^(#{Enum.join(@vowels, "|")})/)

    [_, start, rest] = Regex.run(re_get_start_and_rest, word)
    if (Regex.match?(re_starts_with_vowel, start)) do
      word <> "ay"
    else
      rest <> start <> "ay"
    end
  end

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
      |> String.split()
      |> Enum.map(&translate_word/1)
      |> Enum.join(" ")
  end
end
