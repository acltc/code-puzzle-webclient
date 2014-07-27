class PuzzlesController < ApplicationController

  def home
  end

  def show
      @puzzle = Puzzle.find(params[:id])
  end

  def index
    url = "http://localhost:3000/api/v1/puzzles.json"
    url = url + "?q=#{params[:q]}" if params[:q]
    @puzzles = Unirest.get(url, :headers => {"Accept" => "application/json"}).body
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

