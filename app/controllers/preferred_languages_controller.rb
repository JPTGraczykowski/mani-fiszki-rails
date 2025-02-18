class PreferredLanguagesController < ApplicationController
  def toggle_language
    new_language = session[:preferred_language] == "english" ? "polish" : "english"
    session[:preferred_language] = new_language
    head :ok
  end
end
