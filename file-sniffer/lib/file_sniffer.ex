defmodule FileSniffer do
  @type file_binary() :: binary()
  @type extension() :: String.t()
  @exe_signature <<0x7F::size(8), 0x45::size(8), 0x4C::size(8), 0x46::size(8)>>
  @bmp_signature <<0x42::size(8), 0x4D::size(8)>>
  @png_signature <<0x89::size(8), 0x50::size(8), 0x4E::size(8), 0x47::size(8),
                   0x0D::size(8), 0x0A::size(8), 0x1A::size(8), 0x0A::size(8)>>
  @jpg_signature <<0xFF::size(8), 0xD8::size(8), 0xFF::size(8)>>
  @gif_signature <<0x47::size(8), 0x49::size(8), 0x46::size(8)>>

  @spec type_from_extension(extension()) :: String.t()
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
    end
  end

  @spec type_from_binary(file_binary()) :: String.t()
  def type_from_binary(<<@exe_signature, _rest::binary>>) do
    "application/octet-stream"
  end
  def type_from_binary(<<@bmp_signature, _rest::binary>>) do
    "image/bmp"
  end
  def type_from_binary(<<@png_signature, _rest::binary>>) do
    "image/png"
  end
  def type_from_binary(<<@jpg_signature, _rest::binary>>) do
    "image/jpg"
  end
  def type_from_binary(<<@gif_signature, _rest::binary>>) do
    "image/gif"
  end

  @spec verify(file_binary(), extension()) :: tuple()
  def verify(file_binary, extension) do
    if(type_from_extension(extension) == type_from_binary(file_binary)) do
      {:ok, type_from_extension(extension)}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
