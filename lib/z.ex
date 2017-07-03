defmodule Z do
  def h(f1, f2) do
    Code.compiler_options(ignore_module_conflict: true)
    {:ok, ast} = Code.string_to_quoted(File.read!("lib/q.ex"))
    Macro.prewalk(ast, :s1, fn x, acc ->
      case acc do
        :s1 ->
          case x do
            {:def, _, _} ->
              {x, :s2}
            _ ->
              {x, :s1}
          end
        :s2 ->
          case x do
            {^f1, _, _} ->
              {x, :s3}
            _ ->
              {x, :s1}
          end
        :s3 ->
          try do
            Keyword.update!(x, :do, fn y -> 
              quote do
                unquote({f2, [], []})
                unquote(y)
              end 
            end)
          rescue
            _ -> {x, :s3}
          else
            value -> {value, :s1}
          end
      end
    end)
    |> elem(0)
    |> Macro.to_string()
    |> Code.compile_string()
    :ok
  end
end