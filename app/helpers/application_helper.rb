module ApplicationHelper
  def preferred_language
    session[:preferred_language] || "english"
  end
end
