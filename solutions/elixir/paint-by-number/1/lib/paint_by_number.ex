defmodule PaintByNumber do

  def palette_bit_size(color_count) do
    get_bits(color_count, 0)
  end
  defp get_bits(0, bits), do: bits
  defp get_bits(color_count, bits) do
    if color_count <= 2 ** bits do
      bits
    else
      get_bits(color_count, bits + 1)
    end
  end
  def empty_picture do
    <<>>
  end
  def test_picture do
    <<0::2, 1::2, 2::2, 3::2>>
  end
  def prepend_pixel(picture, color_count, pixel_color_index) do
    bits = palette_bit_size(color_count)
    <<pixel_color_index::size(bits), picture::bitstring>>
  end
  def get_first_pixel(picture, color_count) do
    if picture == <<>> do
      nil
    else
      bits = palette_bit_size(color_count)
      <<first_pixel::size(bits), rest::bitstring>> = picture
      first_pixel
    end
  end
  def drop_first_pixel(picture, color_count) do
    if picture == <<>> do
      <<>>
    else
      bits = palette_bit_size(color_count)
      <<first_pixel::size(bits), rest::bitstring>> = picture
      rest
    end
  end
  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
