class UsersFetcher
  COLUMNS = [:id, :email, :username, :avatar_file_name]

  def initialize(user_ids = [])
    @user_ids = user_ids.flatten.compact.uniq
  end

  def [](user_id)
    users[user_id]
  end

  private

  def users
    @users ||= Hash.new.tap do |users|
      User.where(id: @user_ids).select(COLUMNS).each do |user|
        users[user.id] = user
      end
    end
  end
end
