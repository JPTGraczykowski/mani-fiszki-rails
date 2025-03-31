class SentenceSetsController < ApplicationController
  allow_unauthenticated_access
  layout :resolve_layout

  before_action :set_sentence_set, only: [:show]
  before_action :set_sidebar, only: [:show]

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

  def set_sidebar
    @sidebar_resources = SentenceSet.all
    @active_sidebard_resource = @sentence_set
    @sidebar_resource_path = ->(sentence_set) { sentence_set_path(sentence_set) }
  end
end
