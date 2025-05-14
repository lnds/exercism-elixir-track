defmodule PaintByNumber do
  def palette_bit_size(1), do: 1

  def palette_bit_size(color_count) do
    get_bit_size(color_count, 1)
  end

  def get_bit_size(n, b) do
    if 2 ** b >= n do
      b
    else
      get_bit_size(n, b + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bs = palette_bit_size(color_count)
    <<pixel_color_index::size(bs), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    bs = palette_bit_size(color_count)
    <<first::size(bs), _::bitstring>> = picture
    first
  end

  def drop_first_pixel(<<>>, _), do: <<>>

  def drop_first_pixel(picture, color_count) do
    bs = palette_bit_size(color_count)
    <<_::size(bs), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
