# frozen_string_literal: true

require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  # INDEX -> test for index method
  test 'should get index when pawn is not placed on the board' do
    Move.delete_all
    get boards_url
    assert_response :success
    assert_not response.body.include?('north_white_pawn')
  end

  test 'should get index when pawn is placed on the board' do
    moves(:one)
    get boards_url
    assert_response :success
    assert response.body.include?('north_black_pawn')
  end
end
