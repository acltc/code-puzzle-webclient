class PuzzlesController < ApplicationController


  def index
    @puzzles = Unirest.get("http://localhost:3000/api/v1/puzzles.json", :headers => {"Accept" => "application/json"}).body
    
  end

end