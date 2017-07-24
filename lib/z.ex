defmodule Z do
  def h(f1, f2) do
    z(f1, f2, "lib/q.ex")
  end
  
  def z(f1, f2, path) do
    Code.compiler_options(ignore_module_conflict: true)
    {:ok, ast} = Code.string_to_quoted(File.read!(path))
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
            {^f1, [line: l], _} ->
              IO.inspect l
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

  def i(f1, f2) do
    Code.compiler_options(ignore_module_conflict: true)
    file = File.read!("lib/q.ex")
    {:ok, ast} = Code.string_to_quoted(file)
    lines =
      Macro.prewalk(ast, {:s1, []}, fn x, {s, ls} ->
        case s do
          :s1 ->
            case x do
              {:def, _, _} ->
                {x, {:s2, ls}}
              _ ->
                {x, {:s1, ls}}
            end
          :s2 ->
            case x do
              {^f1, [line: l], _} ->
                {x, {:s1, [l | ls]}}
              _ ->
                {x, {:s1, ls}}
            end
        end
      end)
      |> elem(1)
      |> elem(1)
    new_file = 
      String.split(file, "\n")
      |> Enum.with_index(1)
      |> Enum.map(fn {v, i} -> 
        case Enum.any?(lines, fn x -> x == i end) do
          true -> v <> f_indent() <> "#{f2}()"
          false -> v
        end
      end)
      |> Enum.join("\n")
    File.write!("lib/q.ex", new_file)
    Code.compile_string(new_file)
  end

  defp f_indent(), do: "\n    "

end