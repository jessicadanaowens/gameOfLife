require 'spec_helper'
require './cell_changer'

RSpec.describe CellChanger do
  it "takes board as a parameter" do
    board = []

    cell_changer = CellChanger.new(board)
  end

  describe "#flatten" do
    it "flattens the board into one array" do
      board = [[],[]]
      expect(CellChanger.new(board).flatten).to eq []
    end
  end

  describe "#change" do
    it "returns a board" do
      board = []

      expect(CellChanger.new(board).change).to eq []
    end

    it "kills a cell that has fewer than two live neighbors" do
      x = 'alive'
      o = 'dead'
      board = [[x, o],
               [o, o]]

      expect(CellChanger.new(board).change).to eq [[o, o],
                                                   [o, o]]
    end
  end
end


# Any live cell with fewer than two live neighbours dies, as if caused by under-population.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.