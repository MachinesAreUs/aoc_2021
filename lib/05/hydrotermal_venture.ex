defmodule HydrotermalVenture do
  @moduledoc false

  @empty "."

  def line_overlaps(lines) do
    max_x = max_x(lines)
    max_y = max_y(lines)
    mtx = empty_matrix(max_x + 1, max_y + 1)
    mtx = mark_lines(mtx, lines)
    count_overlaps(mtx)
  end

  def mark_lines(mtx, []), do: mtx

  def mark_lines(mtx, [h | t]) do
    mtx = mark_line(mtx, h)
    mark_lines(mtx, t)
  end

  def mark_line(mtx, [{x1, y1}, {x2, y2}]) when x1 == x2 do
    Enum.reduce(y1..y2, mtx, fn y, acc ->
      mark_point(acc, {x1, y})
    end)
  end

  def mark_line(mtx, [{x1, y1}, {x2, y2}]) when y1 == y2 do
    Enum.reduce(x1..x2, mtx, fn x, acc ->
      mark_point(acc, {x, y1})
    end)
  end

  def mark_line(mtx, _line) do
    mtx
  end

  def mark_point(mtx, {x, y}) do
    mtx
    |> Enum.with_index()
    |> Enum.map(fn {row, y_idx} ->
      if y == y_idx, do: mark_col(row, x), else: row
    end)
  end

  def mark_col(row, x) do
    case Enum.at(row, x) do
      @empty -> List.replace_at(row, x, 1)
      num -> List.replace_at(row, x, num + 1)
    end
  end

  def max_x(lines) do
    Enum.reduce(lines, 0, fn [{x1, _}, {x2, _}], acc ->
      Enum.max([acc, x1, x2])
    end)
  end

  def max_y(lines) do
    Enum.reduce(lines, 0, fn [{_, y1}, {_, y2}], acc ->
      Enum.max([acc, y1, y2])
    end)
  end

  def count_overlaps(mtx) do
    Enum.reduce(mtx, 0, fn row, mtx_count ->
      count =
        Enum.reduce(row, 0, fn item, row_count ->
          case item do
            @empty -> row_count
            1 -> row_count
            _ -> row_count + 1
          end
        end)
      mtx_count + count
    end)
  end

  def empty_matrix(width, depth) do
    Enum.map(0..(depth-1), fn _ ->
      Enum.map(0..(width-1), fn _ -> @empty end)
    end)
  end
end
