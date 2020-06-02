class Score
  class << self
    def create(user_id = 'me')
      all = []
      FlatService.get_scores(user_id).each { |score| all << Score.new(score) }
      all
    end

    def show(score_id)
      Score.new(FlatService.get_score(score_id))
    end

    def delete(score_id)
      FlatService.delete_score(score_id)
    end

    def new_score(title)
      FlatService.create_score(title)
    end

    def add_collaborator(score_id, user_id)
      FlatService.add_collaborator(score_id, user_id)
    end
  end

  attr_reader :title, :id, :collaborators, :owner

  def initialize(score)
    @title = score[:title]
    @id = score[:id]
    @collaborators = find_collaborators(score[:collaborators])
    @owner = score[:user][:username]
  end

  def current_collaborator?(username)
    @collaborators.each do |collab|
      return true if collab[:username] == username
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

  def user_pending_request?(username)
    return true if Request.where(score: @id).where(username: username) != []

    false
  end

  def find_collaborators(collaborators)
    collaborator_records = []
    collaborators.each do |collaborator|
      user_lookup = User.find_by(username: collaborator[:user][:username])
      collaborator_records << user_lookup if !user_lookup.nil?
    end
    collaborator_records
  end
end
