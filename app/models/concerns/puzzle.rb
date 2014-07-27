class Puzzle
  attr_accessor :id, :name, :instruction, :solution


 def self.find(id)
    hash = Unirest.get("http://localhost:3000/puzzles/#{id}.json", :headers => {"Accept"=>"application/json"}).body
    return Puzzle.new(hash)
  end