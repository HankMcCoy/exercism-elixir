defmodule Bob do
  def hey(input) do
    cond do
        # Is it silence?
        Regex.match?(~r/^\s*$/, input) -> "Fine. Be that way!"
        # Is it a question?
        Regex.match?(~r/\?$/, input) -> "Sure."
        # Is it a shout?
        # I.e., is there at least one capital letter and no lower-case letters?
        Regex.match?(~r/\p{Lu}/u, input) and !Regex.match?(~r/\p{Ll}/u, input) -> "Whoa, chill out!"
        # Anything else
        true -> "Whatever."
    end
  end
end
