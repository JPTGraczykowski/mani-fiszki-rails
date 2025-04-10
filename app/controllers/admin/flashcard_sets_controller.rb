class Admin::FlashcardSetsController < Admin::BaseController
  layout :resolve_layout
  before_action :set_flashcard_set, only: [:edit, :show, :update, :destroy]
  before_action :set_sidebar, only: [:new, :edit]

  def index
    @flashcard_sets = FlashcardSet.all.includes(:flashcards)
  end

  def new
    @flashcard_set = FlashcardSet.new
  end

  def edit
    @flashcards = @flashcard_set.flashcards
  end

  def show
  end

  def create
    @flashcard_set = FlashcardSet.new(flashcard_set_params)

    if @flashcard_set.save
      redirect_to edit_admin_flashcard_set_path(@flashcard_set), notice: "Pomyślnie zapisano zestaw."
    else
      flash.now[:alert] = "Nie udało sie zapisać zestawu."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @flashcard_set.update(flashcard_set_params)
      redirect_to edit_admin_flashcard_set_path(@flashcard_set), notice: "Pomyślnie zapisano zestaw."
    else
      @flashcards = @flashcard_set.flashcards
      flash.now[:alert] = "Nie udało sie zapisać zestawu."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flashcard_set.destroy

    redirect_to admin_flashcard_sets_path, notice: "Pomyślnie usunięto zestaw."
  end

  private

  def set_flashcard_set
    @flashcard_set = FlashcardSet.find(params[:id])
  end

  def flashcard_set_params
    params.require(:flashcard_set).permit(:english_name, :polish_name, :active)
  end

  def resolve_layout
    if action_name == "index"
      "application"
    else
      "application_with_sidebar"
    end
  end

  def set_sidebar
    @sidebar_resources = FlashcardSet.all
    @active_sidebard_resource = @flashcard_set
    @sidebar_resource_path = ->(flashcard_set) { edit_admin_flashcard_set_path(flashcard_set) }
  end
end
