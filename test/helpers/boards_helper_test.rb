# frozen_string_literal: true

require 'test_helper'

class BoardsHelperTest < ActionView::TestCase
  # CREATE COLOR ARRAY -> tests to test create_color_array
  test 'should return block color array' do
    assert_equal create_color_array, ['#FFFFFF', '#000000', '#FFFFFF', '#000000', '#FFFFFF', '#000000', '#FFFFFF', '#000000']
    assert_equal create_color_array('reverse'), ['#000000', '#FFFFFF', '#000000', '#FFFFFF', '#000000', '#FFFFFF', '#000000', '#FFFFFF']
  end

  # BLOCK COLOR -> tests to test block color array
  test 'should color value from color set for given index' do
    assert_equal block_color('color_set1', 4), '#FFFFFF'
    assert_equal block_color('color_set2', 3), '#FFFFFF'
  end
end