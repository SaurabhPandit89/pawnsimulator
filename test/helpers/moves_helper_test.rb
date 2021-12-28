# frozen_string_literal: true

require 'test_helper'

class MovesHelperTest < ActionView::TestCase
  # COLOR OPTIONS -> test for color_options method
  test 'should return color options for color select tag' do
    assert_equal color_options, [['White', 'white'], ['Black', 'black']]
  end

  # FACING OPTIONS -> test for facing_options method
  test 'should return facing_options for move direction select tag' do
    assert_equal facing_options, [['NORTH', 'north'], ['SOUTH', 'south'], ['EAST', 'east'], ['WEST', 'west']]
  end

  # NEXT COORDINATE -> test for next_coordinate method
  test 'should return next coordinate' do
    assert_equal next_coordinate('3', '+', '2'), 5
    assert_equal next_coordinate('3', '-'), 2
  end

  # MOVE OPTIONS -> test for move_options method
  test 'should return move options for move select tag' do
    assert_equal move_options(moves(:one)), [[1, 4]]
  end

  test 'should return move options with 2 options when pawn is yet to play its first move' do
    Move.delete_all
    move = Move.new(x_coordinate: 1, y_coordinate: 2, pawn_color: 'white', move_direction: 'north')
    assert_equal move_options(move), [[1, 3], [2, 4]]
  end

  # MOVE X -> test to test move_x method
  test 'should return x coordinate' do
    move = moves(:one)
    assert_equal move_x(move), 2
    Move.delete_all
    assert_equal move_x(Move.new), 0
  end

  # MOVE Y -> test to test move_y method
  test 'should return y coordinate' do
    move = moves(:one)
    assert_equal move_y(move), 3
    Move.delete_all
    assert_equal move_y(Move.new), 0
  end

  # PAWN IMAGE -> test for pawn_image method
  test 'should return pawn image' do
    move = moves(:one)
    assert_equal pawn_image(move), 'north_black_pawn.png'
    Move.delete_all
    assert_equal pawn_image(Move.new), 'north_white_pawn.png'
  end

  # PAWN PLACED -> test for pawn_placed? method
  test 'should return true or false if pawn is placed or not' do
    move = moves(:one)
    assert pawn_placed?(move)
    Move.delete_all
    assert_not pawn_placed?(Move.new)
  end

  # PAWN MOVED ONCE -> test for pawn_moved_once? method
  test 'should return true or false if pawn moved or not' do
    move = moves(:one)
    assert pawn_moved_once?(move)
    Move.delete_all
    assert_not pawn_moved_once?(Move.new)
  end

  # MOVE DIREC -> test for move_direc
  test 'should return sign for move direction' do
    move = moves(:one)
    assert_equal move_direc(move), '+'
    Move.delete_all
    move = Move.new(x_coordinate: 1, y_coordinate: 2, pawn_color: 'white', move_direction: 'west')
    assert_equal move_direc(move), '-'
  end

  # Y AXIS -> test for y_axis?
  test 'should return true if direction is in y-axis' do
    move = moves(:one)
    assert y_axis?(move)
    Move.delete_all
    move = Move.new(x_coordinate: 1, y_coordinate: 2, pawn_color: 'white', move_direction: 'west')
    assert_not y_axis?(move)
  end

  # MOVE_COORDINATE -> test for move_coordinate
  test 'should return select id for move select tag' do
    move = moves(:one)
    assert_equal move_coordinate(move), 'move[y_coordinate]'
    Move.delete_all
    move = Move.new(x_coordinate: 1, y_coordinate: 2, pawn_color: 'white', move_direction: 'west')
    assert_equal move_coordinate(move), 'move[x_coordinate]'
  end

  # LEFT_OF -> test for left_of method
  test 'should return left of given direction' do
    assert_equal left_of[:north], 'west'
    assert_equal left_of[:west], 'south'
    assert_equal left_of[:south], 'east'
    assert_equal left_of[:east], 'north'
  end

  # RIGHT_OF -> test for right_of method
  test 'should return right of given direction' do
    assert_equal right_of[:north], 'east'
    assert_equal right_of[:west], 'north'
    assert_equal right_of[:south], 'west'
    assert_equal right_of[:east], 'south'
  end

  # BUILD MESSAGE LOG -> test for build message log
  test 'should return message for message log for commit type MOVE' do
    previous_move = moves(:one)
    previous_move.update_attribute(:y_coordinate, 5)
    move = Move.first
    assert_equal build_message_log('MOVE', previous_move, {'y_coordinate' => 5}), 'MOVE 0'
  end

  test 'should return message for message log for commit type LEFT' do
    previous_move = moves(:one)
    previous_move.update_attribute(:move_direction, 'west')
    move = Move.first
    assert_equal build_message_log('LEFT', previous_move, {'move_direction' => 'west'}), 'LEFT'
  end

  test 'should return message for message log for commit type RIGHT' do
    previous_move = moves(:one)
    previous_move.update_attribute(:move_direction, 'east')
    move = Move.first
    assert_equal build_message_log('RIGHT', previous_move, {'move_direction' => 'east'}), 'RIGHT'
  end
end