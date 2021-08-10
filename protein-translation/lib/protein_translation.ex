defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    proteins =
      rna
      |> String.codepoints()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.join/1)
      |> Enum.map(&of_codon/1)
      |> Enum.take_while(fn {stat, codon} -> codon != "STOP" end)

    Enum.reduce(proteins, {:ok, []}, fn r, {s, ps} ->
      case r do
        {:ok, p} when is_list(ps) -> {:ok, ps ++ [p]}
        _ -> {:error, "invalid RNA"}
      end
    end)
  end

  @translations %{
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
    "UGA" => "STOP"
  }
  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    protein = @translations[codon]

    if protein do
      {:ok, protein}
    else
      {:error, "invalid codon"}
    end
  end
end
