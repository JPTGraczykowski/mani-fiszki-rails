class FlashcardSetsController < ApplicationController
  layout :resolve_layout
  before_action :set_flashcard_set, only: [:show]

  def index
    @flashcard_sets = FlashcardSet.all
  end

  def show
    @flashcards = @flashcard_set.flashcards
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
