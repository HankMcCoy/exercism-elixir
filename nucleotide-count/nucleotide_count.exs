defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    case strand do
      [] -> 0
      [hd | rest] when hd == nucleotide -> count(rest, nucleotide) + 1
      [_ | rest] -> count(rest, nucleotide)
      _ -> raise "Invalid argument"
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    update_counts(strand, Map.new(@nucleotides, &{&1, 0}))
  end

  defp update_counts(strand, counts) do
    case strand do
      [] -> counts
      [hd | rest] -> Map.update!(update_counts(rest, counts), hd, &(&1 + 1))
      _ -> raise "Invalid argument"
    end
  end
end
