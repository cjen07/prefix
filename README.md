# Prefix

## "add" g to f

```elixir
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
```

```elixir
iex -S mix
Q.f
# => world
# => :ok
Q.ff
# => world
# => world
# => :ok
Q.f "cjen07"
# => cjen07
# => :ok
Z.h :f, :g
# => :ok
Q.f
# => hello
# => world
# => :ok
Q.f "cjen07"
# => hello
# => cjen07
# => :ok
Q.ff
# => hello
# => world
# => hello
# => world
# => :ok
Z.h :f, :i
# => :ok
Q.f
# => world
# => :ok
Q.ff
# => world
# => world
# => :ok
Q.f "cjen07"
# => cjen07
# => :ok
```
