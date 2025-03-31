class Admin::SentenceSetsController < Admin::BaseController
  layout :resolve_layout
  before_action :set_sentence_set, only: [:edit, :show, :update, :destroy]
  before_action :set_sidebar, only: [:new, :edit]

  def index
    @sentence_sets = SentenceSet.all.includes(:sentences)
  end

  def new
    @sentence_set = SentenceSet.new
  end

  def edit
    @sentences = @sentence_set.sentences
  end

  def show
  end

  def create
    @sentence_set = SentenceSet.new(sentence_set_params)

    if @sentence_set.save
      redirect_to edit_admin_sentence_set_path(@sentence_set), notice: "Pomyślnie zapisano zestaw."
    else
      flash.now[:alert] = "Nie udało sie zapisać zestawu."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @sentence_set.update(sentence_set_params)
      redirect_to edit_admin_sentence_set_path(@sentence_set), notice: "Pomyślnie zapisano zestaw."
    else
      @sentences = @sentence_set.sentences
      flash.now[:alert] = "Nie udało sie zapisać zestawu."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sentence_set.destroy

    redirect_to admin_sentence_sets_path, notice: "Pomyślnie usunięto zestaw."
  end

  private

  def set_sentence_set
    @sentence_set = SentenceSet.find(params[:id])
  end

  def sentence_set_params
    params.require(:sentence_set).permit(:english_name, :polish_name, :active)
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
    @sidebar_resource_path = ->(sentence_set) { admin_sentence_set_path(sentence_set) }
  end
end
