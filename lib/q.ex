defmodule Q do
  
  def f() do
    IO.puts "world"
  end

  def g() do
    IO.puts "hello"
  end

  def h(f1, f2) do
    Code.compiler_options(ignore_module_conflict: true)
    {:ok, ast} = Code.string_to_quoted(File.read!("lib/q.ex"))
    Macro.prewalk(ast, :s1, fn x, acc -> 
      case acc do
        :s3 ->
          {x, :s3}
        :s1 ->
          case x do
            {^f1, _, _} ->
              {x, :s2}
            _ ->
              {x, :s1}
          end
        :s2 ->
          {
            Keyword.update!(x, :do, fn y -> 
              quote do
                unquote({f2, [], []})
                unquote(y)
              end 
            end),
            :s3
          } 
      end
    end)
    |> elem(0)
    |> Macro.to_string()
    |> Code.compile_string()
    :ok
  end

end
