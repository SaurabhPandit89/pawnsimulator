# frozen_string_literal: true

# Model Move resposible for all the pawn movements
class Move < ApplicationRecord
  validates_presence_of :x_coordinate,
                        :y_coordinate,
                        :move_direction,
                        :pawn_color,
                        :is_placed

  validate :valid_move

  before_validation :set_attributes

  def moved_once?
    moved_once
  end

  def placed?
    is_placed
  end

  def pawn_color?
    pawn_color
  end

  private

  def set_attributes
    self.moved_once = 1 if placed?
    self.is_placed = 1 unless placed?
  end

  def valid_move
    return unless (x_coordinate > 8 || x_coordinate < 1) || (y_coordinate > 8 || y_coordinate < 1)

    errors.add(:base, 'Invalid Move')
  end
end
