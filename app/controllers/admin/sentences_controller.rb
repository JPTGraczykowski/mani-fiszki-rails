class Admin::SentencesController < Admin::BaseController
  before_action :set_sentence_set
  before_action :set_sentence, only: [:edit, :update, :destroy, :reorder]
  before_action :set_max_position, only: [:new, :edit]

  def index
    @sentences = @sentence_set.sentences
  end

  def new
    @sentence = @sentence_set.sentences.new(position: @max_position + 1)
  end

  def edit
  end

  def create
    @sentence = @sentence_set.sentences.new(sentence_params)

    if @sentence.save
      respond_to do |format|
        format.html { redirect_to edit_admin_sentence_set_path(@sentence_set), notice: "Pomyślnie zapisano zdanie." }
        format.turbo_stream { flash.now[:notice] = "Pomyślnie zapisano zdanie." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @sentence.update(sentence_params)
      respond_to do |format|
        format.html { redirect_to edit_admin_sentence_set_path(@sentence_set), notice: "Pomyślnie zapisano zdanie." }
        format.turbo_stream { flash.now[:notice] = "Pomyślnie zapisano zdanie." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sentence.destroy

    respond_to do |format|
      format.html { redirect_to admin_sentence_set_path(@sentence_set), notice: "Pomyślnie usunięto zdanie." }
      format.turbo_stream { flash.now[:notice] = "Pomyślnie usunięto zdanie." }
    end
  end

  def reorder
    @sentence.insert_at(params[:position].to_i)
    head :ok
  end

  private

  def set_sentence_set
    @sentence_set = SentenceSet.find(params[:sentence_set_id])
  end

  def set_sentence
    @sentence = @sentence_set.sentences.find(params[:id])
  end

  def set_max_position
    @max_position = @sentence_set.sentences.size
  end

  def sentence_params
    params.require(:sentence).permit(:translation, :position)
  end
end
