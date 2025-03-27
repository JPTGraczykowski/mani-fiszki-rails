class SentenceSetsController < ApplicationController
  allow_unauthenticated_access
  layout :resolve_layout
  before_action :set_sentence_set, only: [:show]

  def index
    @sentence_sets = SentenceSet.active
  end

  def show
    @sentences = @sentence_set.sentences
    @current_index = params[:index].to_i || 0
    @current_sentence = @sentences[@current_index]
  end

  private

  def set_sentence_set
    @sentence_set = SentenceSet.find(params[:id])
  end

  def resolve_layout
    if action_name == "index"
      "application"
    else
      "application_with_sidebar"
    end
  end
end
