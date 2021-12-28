# frozen_string_literal: true

# Controller to facilitate pawn movement on the board
class MovesController < ApplicationController
  protect_from_forgery except: :show

  before_action :set_move, only: %i[show update destroy]
  before_action :set_previous_move, only: :update

  def create
    @move = Move.new(place_params)
    @move.save
    redirect_to root_path
  end

  def update
    respond_to do |format|
      @move.update(move_params) ? format.js : format.js { render 'error' }
    end
  end

  def show; end

  def destroy
    redirect_to root_path if @move.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_move
    @move = Move.find(params[:id])
  end

  def set_previous_move
    @previous_move = Move.find(params[:id])
    @move_type = params[:commit]
    @coordinate_type = params[:move]
  end

  # Only allow a list of trusted parameters through.
  def place_params
    params.require(:place).permit(:x_coordinate, :y_coordinate, :move_direction, :pawn_color)
  end

  # Only allow a list of trusted parameters through.
  def move_params
    params.require(:move).permit(:x_coordinate, :y_coordinate, :move_direction)
  end
end
