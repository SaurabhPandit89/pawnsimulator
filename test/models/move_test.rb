# frozen_string_literal: true

require 'test_helper'

class MoveTest < ActiveSupport::TestCase
  # VALIDATE PRESENCE -> tests to validate presence and uniqueness of tag name
  test 'should not create if move direction is missing' do
    assert_not Move.new(x_coordinate: 1, y_coordinate: 2, pawn_color: 'white').save
  end

  test 'should not create if pawn color is missing' do
    assert_not Move.new(x_coordinate: 1, y_coordinate: 2, move_direction: 'north').save
  end

  # SET_ATTRIBUTE -> test for set_attribute method
  test 'should set attributes before validation' do
    move = Move.new(x_coordinate: 1, y_coordinate: 2, pawn_color: 'white', move_direction: 'north')
    assert move.valid?
  end

  test 'moved_once? when no move is present' do
    Move.delete_all
    assert_not Move.new.moved_once?
  end

  test 'moved_once? when move is present' do
    assert moves(:one).moved_once?
  end

  test 'placed? when no move is present' do
    Move.delete_all
    assert_not Move.new.placed?
  end

  test 'placed? when move is present' do
    assert moves(:one).placed?
  end

  test 'pawn_color? when no move is present' do
    Move.delete_all
    assert_not Move.new.pawn_color?
  end

  test 'pawn_color? when move is present' do
    assert moves(:one).pawn_color?
  end

  test 'valid_move?' do
    move = Move.new(x_coordinate: 9, y_coordinate: 2, pawn_color: 'white', move_direction: 'north')
    move.valid?
    assert_equal move.errors.full_messages[0], 'Invalid Move'
  end
end
