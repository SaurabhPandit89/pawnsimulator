# frozen_string_literal: true

# Module to keep helper methods for board view
module BoardsHelper
  def create_color_array(order = '')
    colors = ['#FFFFFF', '#000000']
    colors = colors.reverse if order == 'reverse'
    Array.new(4, colors).flatten
  end

  def block_color(color_set, index)
    color_set1 = create_color_array
    color_set2 = create_color_array('reverse')
    color_set = color_set == 'color_set1' ? color_set1 : color_set2
    instance_eval <<-COLOR, __FILE__, __LINE__ + 1
      #{color_set}[#{index}]
    COLOR
  end
end
