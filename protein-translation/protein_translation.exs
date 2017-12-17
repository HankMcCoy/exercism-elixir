defmodule ProteinTranslation do
  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP",
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    codon_list = rna
      |> to_charlist
      |> Enum.chunk_every(3)
      |> Enum.map(&to_string/1)
      |> Enum.map(&(@codons[&1]))

    if (Enum.any?(codon_list, &(&1 == nil))) do
      { :error, "invalid RNA" }
    else
      { :ok, Enum.take_while(codon_list, &(&1 != "STOP"))}
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case @codons[codon] do
      nil -> { :error, "invalid codon" }
      _ -> { :ok, @codons[codon] }
    end
  end
end
