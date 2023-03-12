defmodule TopSecret do
  defguard dfun(a) when a in [:def, :defp]
  def to_ast(string) do
    string
    |> Code.string_to_quoted!()
  end

  def decode_secret_message_part(ast = {a, _b, [{_c, _fbody, nil} | _]}, acc) when dfun(a) do
    {ast, ["" | acc]}
  end

  def decode_secret_message_part(ast = {a, _b, [{:when, _wfbody, [{c, _fbody, fparams} | _]} | _]}, acc) when dfun(a) do
    {ast, [c |> Atom.to_string() |> String.slice(0, Enum.count(fparams)) | acc]}
  end

  def decode_secret_message_part(ast = {a, _b, [{c, _fbody, fparams} | _]}, acc) when dfun(a) do
    {ast, [c |> Atom.to_string() |> String.slice(0, Enum.count(fparams)) | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    {_, acc} =
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    acc |> Enum.reverse() |> List.to_string()
  end
end
