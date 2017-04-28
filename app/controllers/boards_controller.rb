class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :update, :destroy]

  def index
    @boards = Board.all

    render json: @boards
  end

  # GET /doctors/1
  def show
    render json: @board
  end

  # PATCH/PUT /doctors/1
  def update
    if @board.update(board_params)
      render json: @board
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/1
  def destroy
    @board.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params[:id])
  end

  # # Only allow a trusted parameter "white list" through.
  def board_params
    params.require(:board).permit(:title, :cells)
  end
end
