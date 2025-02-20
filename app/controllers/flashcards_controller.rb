class FlashcardsController < ApplicationController
  before_action :set_flashcard_set

  def index
    @flashcards = @flashcard_set.flashcards
  end

  def hide_flashcards
  end

  private

  def set_flashcard_set
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
  end
end
