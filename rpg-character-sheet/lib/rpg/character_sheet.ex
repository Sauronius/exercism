defmodule RPG.CharacterSheet do
  @spec welcome() :: :ok
  def welcome() do
    # Please implement the welcome/0 function
    "Welcome! Let's fill out your character sheet together."
    |> IO.puts()
  end

  @spec ask_name() :: String.t
  def ask_name() do
    # Please implement the ask_name/0 function
    IO.gets("What is your character's name?\n") |> String.trim()
  end

  @spec ask_class() :: String.t
  def ask_class() do
    # Please implement the ask_class/0 function
    IO.gets("What is your character's class?\n") |> String.trim()
  end

  @spec ask_level() :: non_neg_integer()
  def ask_level() do
    # Please implement the ask_level/0 function
    IO.gets("What is your character's level?\n")
    |> String.trim()
    |> String.to_integer()
  end

  @spec run() :: Map
  def run() do
    # Please implement the run/0 function
    welcome()
    #name = ask_name()
    #class = ask_class()
    #level = ask_level()
    %{name: ask_name(), class: ask_class(), level: ask_level()}
    |> IO.inspect(label: "Your character")
  end
end
