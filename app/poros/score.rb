class Score
  class << self
    def create
      all = []
      FlatService.get_scores.each { |score| all << Score.new(score) }
      all
    end

    def show(score_id)
      Score.new(FlatService.get_score(score_id))
    end

    def delete(score_id)
      FlatService.delete_score(score_id)
    end
  end

  attr_reader :title, :id

  def initialize(score)
    @title = score[:title]
    @id = score[:id]
  end
end
