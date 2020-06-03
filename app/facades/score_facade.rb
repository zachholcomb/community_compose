class ScoreFacade
  attr_reader :all_scores
    
  def initialize
    @all_scores = Score.create
  end

end