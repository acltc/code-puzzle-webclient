class PuzzlesController < ApplicationController


  def show
      @puzzle = Puzzle.find(params[:id])
    end

  end
  def index
    @puzzles = Unirest.get("http://localhost:3000/api/v1/puzzles.json", :headers => {"Accept" => "application/json"}).body
    
  end

  def create
    @puzzle = Unirest.post("http://localhost:3000/api/v1/puzzles.json",
                  headers: {"Accept" => "application/json"},
                  parameters: { :puzzle => 
                                {
                                  :name => params[:name],
                                  :instructions => params[:instructions],
                                  :solution => params[:solution] 
                                }
                            }
                          ).body
    redirect_to puzzle_path(@puzzle["id"])
  end


  

end

