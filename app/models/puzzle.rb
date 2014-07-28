class Puzzle
  attr_accessor :id, :name, :instructions, :solution. :code_solution

  def initialize(attribute_hash)
    @id = attribute_hash["id"]
    @name = attribute_hash["name"]
    @instructions = attribute_hash["instructions"]
    @code_solution = ""
    end  

  def solution_correct?
    if code_solution
  end

 def self.find(id)
    hash = Unirest.get("http://localhost:3000/api/v1/puzzles/#{id}.json", :headers => {"Accept"=>"application/json"}).body
    return Puzzle.new(hash)
  end

end