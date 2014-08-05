
class PuzzlesController < ApplicationController

  def home
  end

  def about
  end

  def rankings
    users_unsorted = User.all
    least_to_greatest = users_unsorted.sort_by {|user| user.score}
    @users = least_to_greatest.reverse
  end

  def show
    @puzzle = Puzzle.find(params[:id])
   end

  def index
    if params[:q]
      @puzzles = Puzzle.search(params[:q])
    else
      @puzzles = Puzzle.all      
    end
  end

  def create
    @puzzle = Unirest.post("#{ENV['API_HOST']}/puzzles.json",
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

  def check_solution
    hash = Unirest.get("#{ENV['API_HOST']}/puzzles/solutions/#{params[:id]}.json?solution=#{params[:solution]}", :headers => {"Accept" => "application/json"}).body
    if hash["response"].downcase == "correct"
      flash[:success] = "That's the correct answer!"
      TrackSuccess.create(:user_id=> current_user.id, :puzzle_id => params[:id], :success => true)
    elsif hash["response"].downcase == "incorrect"
      flash[:danger] = "That's the wrong answer. Try again!"
      TrackSuccess.create(:user_id=> current_user.id, :puzzle_id => params[:id], :success => false)
    else
      flash[:notice] = "Something went wrong. Sorry!"
    end
    redirect_to puzzle_path(params[:id])
  end

  def check_code_solution
   @code_solution = eval(params[:code_solution]) 
    hash = Unirest.get("#{ENV['API_HOST']}/puzzles/solutions/#{params[:id]}.json?solution=#{@code_solution}", :headers => {"Accept" => "application/json"}).body
    puts @code_solution
    puts "00000000000000000000"
    if hash["response"].downcase == "correct"
      flash[:success] = "That's the correct answer!"
    else
      flash[:danger] = "That's the wrong answer. Try again!"
    end
    redirect_to puzzle_path(params[:id])
  end



end

