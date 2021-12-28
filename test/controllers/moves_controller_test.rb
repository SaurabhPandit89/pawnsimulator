# frozen_string_literal: true

require 'test_helper'

class MovesControllerTest < ActionDispatch::IntegrationTest
  # CREATE -> test for create method
  test 'should create pawn with attributes' do
    assert_difference('Move.count') do
      post moves_url, params: { place: { 'x_coordinate' => '1', 'y_coordinate' => '1',
                                         'move_direction' => 'north', 'pawn_color' => 'white' } }
    end
    assert_response :redirect
  end

  test 'should render error if it fails to create pawn with attributes' do
    assert_no_difference('Move.count') do
      post moves_url, params: { place: { 'x_coordinate' => '9', 'y_coordinate' => '1',
                                         'move_direction' => 'north', 'pawn_color' => 'white' } }
    end
    assert_response :redirect
  end

  # UPDATE -> test for update method
  test 'should update MOVE on y-axis' do
    patch move_url(moves(:one)), params: { move: { 'y_coordinate' => '4' }, commit: 'MOVE', format: :js }
    assert_response 200
    assert response.body.include?('MOVE 1')
    assert_not response.body.include?('Invalid Move')
  end

  test 'should not update MOVE on y-axis if it is falling from board' do
    patch move_url(moves(:one)), params: { move: { 'y_coordinate' => '9' }, commit: 'MOVE', format: :js }
    assert_response 200
    assert response.body.include?('Invalid Move')
  end

  test 'should update MOVE on x-axis' do
    patch move_url(moves(:one)), params: { move: { 'x_coordinate' => '4' }, commit: 'MOVE', format: :js }
    assert_response 200
    assert response.body.include?('MOVE 2')
    assert_not response.body.include?('Invalid Move')
  end

  test 'should not update MOVE on x-axis if it is falling from board' do
    patch move_url(moves(:one)), params: { move: { 'x_coordinate' => '9' }, commit: 'MOVE', format: :js }
    assert_response 200
    assert response.body.include?('Invalid Move')
  end

  test 'should update move direction when LEFT button is pressed' do
    patch move_url(moves(:one)), params: { move: { 'move_direction' => 'east' }, commit: 'LEFT', format: :js }
    assert_response 200
    assert response.body.include?('LEFT')
    assert_not response.body.include?('Invalid Move')
  end

  test 'should update move direction when RIGHT button is pressed' do
    patch move_url(moves(:one)), params: { move: { 'move_direction' => 'west' }, commit: 'RIGHT', format: :js }
    assert_response 200
    assert response.body.include?('RIGHT')
    assert_not response.body.include?('Invalid Move')
  end

  # SHOW -> test for show method
  test 'should REPORT pawn status' do
    get move_url(moves(:one)), params: { commit: 'REPORT', format: :js }
    assert_response 200
    assert response.body.include?('REPORT 2 3 north black')
  end

  # DESTROY -> test for destroy method
  test 'should RESET pawn placement' do
    assert_difference('Move.count', -1) do
      delete move_url(moves(:one))
    end
    assert_response :redirect
  end
end
