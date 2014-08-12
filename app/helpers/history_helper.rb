module HistoryHelper
  def whodunnit(version)
    user_id = version.whodunnit.to_i
    User.find(user_id).name
  rescue ActiveRecord::RecordNotFound
    "Unknown user-#{user_id}"
  end
end
