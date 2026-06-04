defmodule Newsletter do
  def read_emails(path) do
    {:ok, contents} = File.read(path)
    String.split(contents, "\n", trim: true)
  end

  def open_log(path) do
    # Creates a PID, not need spawn a process, just open the file and return the PID
    {:ok, file} = File.open(path, [:write])
    file
  end

  @spec log_sent_email(atom() | pid(), binary()) :: :ok
  def log_sent_email(pid, email) do
    IO.binwrite(pid, email <> "\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    log_file = open_log(log_path)

    Enum.each(emails, fn email ->
      if send_fun.(email) == :ok do
        log_sent_email(log_file, email)
      end
    end)

    close_log(log_file)
    :ok
  end
end
