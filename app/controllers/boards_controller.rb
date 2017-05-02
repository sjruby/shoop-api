class BoardsController < ProtectedController
  before_action :set_board, only: [:show, :update, :destroy]

  def index
    @boards = Board

    render json: @boards
  end

  def listboards
    @boards = Board.where(user: current_user.id)

    render json: @boards
  end

  # GET /doctors/1
  def show
    render json: @board
  end

  # POST data
  def create
    @new_board = current_user.boards.build(board_params)

    if @new_board.save
      render json: @new_board, status: :created, location: @new_board
    else
      render json: @new_board.errors, status: :unprocessable_entity
    end
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
    @board = current_user.boards.find(params[:id])
  end

  # # Only allow a trusted parameter "white list" through.
  def board_params
    params.permit(:title, :cells)
  end
end
