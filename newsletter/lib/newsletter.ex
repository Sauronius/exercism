defmodule Newsletter do
  @spec read_emails(String.t()) :: list()
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  @spec open_log(String.t()) :: pid()
  def open_log(path) do
    path
    |> String.trim()
    |> File.open!([:write])
  end

  @spec log_sent_email(pid(), String.t()) :: :ok
  def log_sent_email(pid, email) do
    pid
    |> IO.puts(email)
  end

  @spec close_log(pid()) :: :ok
  def close_log(pid) do
    pid
    |> File.close
  end

  @spec send_newsletter(String.t(), String.t(), (String.t() -> :ok)) :: :ok
  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)
    emails_path
    |> read_emails()
    |> Enum.each(fn x ->
      case send_fun.(x) do
      :ok -> log_sent_email(pid, x)
      :error -> nil
      end
    end)
    pid |> close_log()
  end
end
