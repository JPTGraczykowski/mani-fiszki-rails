class SentencesController < ApplicationController
  allow_unauthenticated_access

  before_action :set_sentence_set
  before_action :set_sentence

  def show
  end

  def hide_translation
  end

  private

  def set_sentence_set
    @sentence_set = SentenceSet.find(params[:sentence_set_id])
  end

  def set_sentence
    @current_sentence = @sentence_set.sentences.find(params[:id])
  end
end
