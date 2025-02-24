class FlashcardSetsController < ApplicationController
  allow_unauthenticated_access
  layout :resolve_layout
  before_action :set_flashcard_set, only: [:show]

  def index
    @flashcard_sets = FlashcardSet.active
  end

  def show
    @flashcards = @flashcard_set.flashcards
    @current_index = params[:index].to_i || 0
    @current_flashcard = @flashcards[@current_index]
  end

  private

  def set_flashcard_set
    @flashcard_set = FlashcardSet.find(params[:id])
  end

  def resolve_layout
    if action_name == "index"
      "application"
    else
      "application_with_sidebar"
    end
  end
end
