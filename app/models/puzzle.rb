class Puzzle
  attr_accessor :id, :name, :instructions, :solution, :code_solution

  def initialize(attribute_hash)
    @id = attribute_hash["id"]
    @name = attribute_hash["name"]
    @instructions = attribute_hash["instructions"]
    @code_solution = ""
    end  

  def solution_correct?
   
  end

 def self.find(id)
    hash = Unirest.get("http://localhost:3000/api/v1/puzzles/#{id}.json", :headers => {"Accept"=>"application/json"}).body
    return Puzzle.new(hash)
  end

  def self.all
    array = Unirest.get("http://localhost:3000/api/v1/puzzles.json", headers:{ "Accept" => "application/json" }).body
    puzzles = []
    array.each do |puzzle|
      puzzles << Puzzle.new(puzzle)
    end
    return puzzles
  end

  def self.search(search_term)
    url = "http://localhost:3000/api/v1/puzzles.json"
    url = url + "?q=#{search_term}"
    array = Unirest.get(url, headers:{ "Accept" => "application/json" }).body
    puzzles = []
    array.each do |puzzle|
      puzzles << Puzzle.new(puzzle)
    end
    return puzzles
  end

  def diff
    attempts = TrackSuccess.where(:puzzle_id => self.id).count.to_f
    success = TrackSuccess.where(:puzzle_id => self.id, :success => true).count.to_f
    if attempts == 0
      return "uncharted territory"
    else 
      diff = success / attempts
        diff =diff * 100
        return diff.to_i
    end
  end

  def conquered?(user_id)
      if 0 < TrackSuccess.where(:puzzle_id => self.id, :user_id => user_id, :success => true).count
        return true
      else
        return false
      end
  end

  def conquer_count(user_id)
    TrackSuccess.where(:user_id => user_id, :success => true).count
  end

end