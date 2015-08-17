require 'pry'

class CellChanger
  def initialize(board)
    @board = board
    @board_copy = board
    @next_board = []
    @x_index = 0
    @y_index = 0
    @live_neighbors = 0
  end

  def change
    return [] if @board == []

    @board.each_with_index do |y_axis, y_index|
      @next_board[y_index] = []
      y_axis.each_with_index do |x_axis, x_index|
        @next_board[y_index][x_index] = 'o'
        define_indexes(x_index, y_index)

        count_live_neighbors

        if current_cell_is_alive
          apply_rules_to_live_cell
        elsif current_cell_is_dead
          apply_rules_to_dead_cell
        end
        @live_neighbors = 0
      end
    end

    p @board = @next_board
  end

  def define_indexes(x_index, y_index)
    @x_index = x_index
    @y_index = y_index
  end

  def current_cell_is_alive
    @board[@y_index][@x_index] == 'x'
  end

  def current_cell_is_dead
    @board[@y_index][@x_index] == 'o'
  end

  def apply_rules_to_live_cell
    if @live_neighbors  < 2
      @next_board[@y_index][@x_index] = 'o'
    end

    if @live_neighbors == 2 || @live_neighbors == 3
      @next_board[@y_index][@x_index] = 'x'
    end

    if @live_neighbors > 3
      @next_board[@y_index][@x_index] = 'o'
    end
  end

  def apply_rules_to_dead_cell
    if @live_neighbors == 3
      @next_board[@y_index][@x_index] = 'x'
    end
  end

  def count_live_neighbors
    right
    bottom_right
    bottom
    bottom_left
    left
    top_left
    top
    top_right
  end

  def right
    if cell_is_first_in_array
      val = @board[@y_index][@x_index + 1]
    elsif cell_is_last_in_array
      val = 'o'
    else
      val = @board[@y_index][@x_index + 1]
    end

     if val == 'x'
       @live_neighbors += 1
     end
  end

  def bottom_right
    if cell_is_on_bottom_edge
      val = 'o'
    elsif cell_is_last_in_array
      val = 'o'
    else
      val = @board[@y_index + 1][@x_index + 1]
    end

    if val == 'x'
      @live_neighbors += 1
    end
  end

  def bottom
    if cell_is_on_bottom_edge
      val = 'o'
    else
      val = @board[@y_index + 1][@x_index]
    end

    if val == 'x'
      @live_neighbors += 1
    end
  end

  def bottom_left
    if cell_is_on_bottom_edge
      val = 'o'
    elsif cell_is_first_in_array
      val = 'o'
    else
      val = @board[@y_index + 1][@x_index - 1]
    end

    if val == 'x'
      @live_neighbors += 1
    end
  end

  def left
    if cell_is_first_in_array
      val = 'o'
    else
      val = @board[@y_index][@x_index - 1]
    end

    if val == 'x'
      @live_neighbors += 1
    end
  end

  def top_left
    if cell_is_first_in_array
      val = 'o'
    elsif cell_is_on_top_edge
      val = 'o'
    else
      val = @board[@y_index - 1][@x_index - 1]
    end

    if val == 'x'
      @live_neighbors += 1
    end
  end

  def top_right
    if cell_is_on_top_edge
      val = 'o'
    elsif cell_is_last_in_array
      val = 'o'
    else
      val = @board[@y_index - 1][@x_index + 1]
    end

    if val == 'x'
      @live_neighbors += 1
    end
  end

  def bottom
    if cell_is_on_bottom_edge
      val = 'o'
    else
      val = @board[@y_index + 1][@x_index]
    end

    if val == 'x'
      @live_neighbors += 1
    end
  end

  def top
    if cell_is_on_top_edge
      val = 'o'
    else
      val = @board[@y_index - 1][@x_index]
    end

    if val == 'x'
      @live_neighbors += 1
    end
  end

  def cell_is_on_top_edge
    @y_index == 0
  end

  def cell_is_on_bottom_edge
    @y_index == @board.length - 1
  end

  def cell_is_first_in_array
    @x_index == 0
  end

  def cell_is_last_in_array
    @x_index == @board[@y_index].length - 1
  end
end


# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.


#
#
# board1 = [['x', 'x', 'o'],
#           ['x', 'x', 'o'],
#           ['o', 'o', 'o']]

#
# board1 = [['x', 'x', 'o', 'o', 'x'],
#           ['x', 'o', 'o', 'o'],
#           ['o', 'o', 'o', 'x'],
#           ['o', 'o', 'x', 'x']]

slider = [['o', 'o', 'x', 'o', 'o', 'o', 'o', 'x', 'o', 'o'],
          ['x', 'x', 'o', 'x', 'x', 'x', 'x', 'o', 'x', 'x'],
          ['o', 'o', 'x', 'o', 'o', 'o', 'o', 'x', 'o', 'o']]


# board2 = [[x, o, o],
#           [x, o, o],
#           [o, o, o]]

# board3 = [[x, o, o, x],
#           [o, o, o, o],
#           [o, o, o, o],
#           [o, o, o, o]]


#analyze the outside edges
#if a cell on the outside edge should be positive, add that cell to the organism
#if the cell is on the outter left edge, is dead, and has dead above and below it, remove the column
#if the cell is on the right left edge, is dead, and has dead above and below it, remove the column

CellChanger.new(slider).change