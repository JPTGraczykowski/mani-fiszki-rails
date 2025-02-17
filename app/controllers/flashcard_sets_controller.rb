class FlashcardSetsController < ApplicationController
  def index
    @flashcard_sets = FlashcardSet.all
  end
end
