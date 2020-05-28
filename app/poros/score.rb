class Score
  class << self
    def create
      all = []
      FlatService.get_scores.each { |score| all << Score.new(score) }
      all
    end
  end
  attr_reader :title

  def initialize(score)
    @title = score[:title]
  end
end
