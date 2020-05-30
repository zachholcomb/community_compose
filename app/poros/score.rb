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

    def new_score(score_id)
      FlatService.create_score(score_id)
    end
  end

  attr_reader :title, :id, :collaborators

  def initialize(score)
    @title = score[:title]
    @id = score[:id]
    @collaborators = score[:collaborators]
    @owner = score[:user][:username]
  end

  def current_collaborator?(username)
    @collaborators.each do |collab|
      return true if collab[:user][:username] == username
    end
    false
  end

  def owner?(username)
    return true if username == @owner
    false
  end

  def pending_requests
    Request.where(score: @id)
  end
end
