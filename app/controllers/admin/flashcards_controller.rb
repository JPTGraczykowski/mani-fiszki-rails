class Admin::FlashcardsController < Admin::BaseController
  before_action :set_flashcard_set
  before_action :set_flashcard, only: [:edit, :update, :destroy]

  def index
    @flashcards = @flashcard_set.flashcards
  end

  def new
    @flashcard = @flashcard_set.flashcards.new
  end

  def edit
  end

  def create
    @flashcard = @flashcard_set.flashcards.new(flashcard_params)

    if @flashcard.save
      redirect_to edit_admin_flashcard_set_path(@flashcard_set), notice: "Pomyślnie zapisano fiszkę."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    if @flashcard.update(flashcard_params)
      redirect_to edit_admin_flashcard_set_path(@flashcard_set), notice: "Pomyślnie zapisano fiszkę."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flashcard.destroy

    redirect_to admin_flashcard_set_path(@flashcard_set), notice: "Pomyślnie usunięto fiszkę."
  end

  private

  def set_flashcard_set
    @flashcard_set = FlashcardSet.find(params[:flashcard_set_id])
  end

  def set_flashcard
    @flashcard = @flashcard_set.flashcards.find(params[:id])
  end

  def flashcard_params
    params.require(:flashcard).permit(:english_name, :polish_name)
  end
end
