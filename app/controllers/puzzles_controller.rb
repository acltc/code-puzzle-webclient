class PuzzlesController < ApplicationController


def show
    @puzzle = Puzzles.find(params[:id])
  end

end
