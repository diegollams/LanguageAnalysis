class WordsController < ApplicationController

  def index
    @words = Word.all
  end

  def create
    @word = Word.new word_params
    if @word.save
      render json: @word
    else
      render json: @word.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @word = Word.find params[:id]
    head :no_content
  end

private
  def word_params
    params.require(:word).permit(:content,:kind)
  end
end
