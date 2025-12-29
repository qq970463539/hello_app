module MicropostsHelper
  def micropost_time_ago(micropost)
    time_ago_in_words(micropost.created_at) + " ago"
  end
end