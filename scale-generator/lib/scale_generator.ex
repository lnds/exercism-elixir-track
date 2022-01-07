defmodule ScaleGenerator do
  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """
  @spec step(scale :: list(String.t()), tonic :: String.t(), step :: String.t()) ::
          list(String.t())
  def step(scale, tonic, step) do
    pos = Enum.find_index(scale, &(&1 == tonic))

    if pos == nil do
      nil
    else
      pos =
        case step do
          "m" ->
            rem(pos + 1, 12)

          "M" ->
            rem(pos + 2, 12)

          "A" ->
            rem(pos + 3, 12)
        end

      Enum.at(scale, pos)
    end
  end

  @sharp_scale ~w"A A# B C C# D D# E F F# G G#"
  @flat_scale ~w"A Bb B C Db D Eb E F Gb G Ab"
  @flats ~w"F Bb Eb Ab Db Gb d g c f bb eb"

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """
  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic \\ "C") do
    tonic = String.upcase(tonic)

    [
      tonic
      | Stream.unfold({tonic, 1}, fn {t, n} ->
          if n == 13 do
            nil
          else
            new_tonic = step(@sharp_scale, t, "m")
            {new_tonic, {new_tonic, n + 1}}
          end
        end)
        |> Enum.to_list()
    ]
  end

  @doc """
  Sharp notes can also be considered the flat (b) note of the tone above them,
  so the notes can also be represented as:

  A Bb B C Db D Eb E F Gb G Ab

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)
  """
  @spec flat_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def flat_chromatic_scale(tonic \\ "C") do
    [
      tonic
      | Stream.unfold({tonic, 1}, fn {t, n} ->
          if n == 13 do
            nil
          else
            new_tonic = step(@flat_scale, t, "m")
            {new_tonic, {new_tonic, n + 1}}
          end
        end)
        |> Enum.to_list()
    ]
  end

  @doc """
  Certain scales will require the use of the flat version, depending on the
  `tonic` (key) that begins them, which is C in the above examples.

  For any of the following tonics, use the flat chromatic scale:

  F Bb Eb Ab Db Gb d g c f bb eb

  For all others, use the regular chromatic scale.
  """
  @spec find_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def find_chromatic_scale(tonic) do
    is_flat = Enum.any?(@flats, &(&1 == tonic))
    tonic = String.capitalize(tonic)
    scale = if is_flat, do: @flat_scale, else: @sharp_scale

    [
      tonic
      | Stream.unfold({tonic, 1}, fn {t, n} ->
          if n == 13 do
            nil
          else
            new_tonic = step(scale, t, "m") |> String.capitalize()
            {new_tonic, {new_tonic, n + 1}}
          end
        end)
        |> Enum.to_list()
    ]
  end

  @doc """
  The `pattern` string will let you know how many steps to make for the next
  note in the scale.

  For example, a C Major scale will receive the pattern "MMmMMMm", which
  indicates you will start with C, make a full step over C# to D, another over
  D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
  can follow the rest of the pattern to get:

  C D E F G A B C
  """
  @spec scale(tonic :: String.t(), pattern :: String.t()) :: list(String.t())
  def scale(tonic, pattern) do
    is_flat = Enum.any?(@flats, &(&1 == tonic))
    base_scale = if is_flat, do: @flat_scale, else: @sharp_scale
    tonic = String.capitalize(tonic)

    [
      tonic
      | Stream.unfold({tonic, pattern |> String.graphemes()}, fn
          {_, []} ->
            nil

          {t, [s | rest]} ->
            t = String.capitalize(t)
            new_tonic = step(base_scale, t, s)
            {new_tonic, {new_tonic, rest}}
        end)
        |> Enum.to_list()
    ]
  end
end
