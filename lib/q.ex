defmodule Q do
  
  def i() do
    :ok
  end

  def f() do
    IO.puts "world"
  end

  def g() do
    IO.puts "hello"
  end

  def f(a) do
    IO.puts a
  end

  def ff() do
    f()
    f()
  end

end
