class Admin::FlashcardSetsController < Admin::BaseController
  layout :resolve_layout
  before_action :set_flashcard_set, only: [:edit, :show, :update, :destroy]

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
      redirect_to admin_flashcard_sets_path, notice: "Pomyślnie zapisano zestaw."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    if @flashcard_set.update(flashcard_set_params)
      redirect_to admin_flashcard_sets_path, notice: "Pomyślnie zapisano zestaw."
    else
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
    params.require(:flashcard_set).permit(:english_name, :polish_name)
  end

  def resolve_layout
    if action_name == "index"
      "application"
    else
      "application_with_sidebar"
    end
  end
end
