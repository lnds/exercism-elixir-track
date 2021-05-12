defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna |>
    Enum.map(fn nucleotide ->  
        case nucleotide do
          ?G -> ?C
          ?C -> ?G
          ?T -> ?A
          ?A -> ?U
          nucleotide -> nucleotide
        end
      end
    )
  end
end
