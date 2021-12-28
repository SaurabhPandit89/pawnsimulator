# frozen_string_literal: true

# Migration file to create Moves table
class CreateMoves < ActiveRecord::Migration[6.1]
  def change
    create_table :moves do |t|
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.string :pawn_color
      t.string :move_direction
      t.boolean :is_placed
      t.boolean :moved_once

      t.timestamps
    end
  end
end
