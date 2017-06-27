# Prefix

## "add" g to f

```elixir
iex -S mix
Q.f
# => world
# => :ok
Q.g
# => hello
# => :ok
Q.h :f, :g
# => :ok
Q.f
# => hello
# => world
# => :ok
```
