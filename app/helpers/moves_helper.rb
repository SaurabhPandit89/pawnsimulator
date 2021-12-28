# frozen_string_literal: true

# Module to keep moves helper method
module MovesHelper
  def color_options
    [%w[White white], %w[Black black]]
  end

  def facing_options
    [%w[NORTH north], %w[SOUTH south], %w[EAST east], %w[WEST west]]
  end

  def next_coordinate(coordinate, sign, move_factor = '1')
    instance_eval <<-COORDINATE, __FILE__, __LINE__ + 1
      #{coordinate} #{sign} #{move_factor}
    COORDINATE
  end

  def move_options(move)
    sign = move_direc(move)
    coordinate = y_axis?(move) ? move.y_coordinate : move.x_coordinate
    return [[1, next_coordinate(coordinate, sign)]] if move.moved_once?

    [[1, next_coordinate(coordinate, sign)], [2, next_coordinate(coordinate, sign, '2')]]
  end

  def move_x(move)
    move.try(:x_coordinate) || 0
  end

  def move_y(move)
    move.try(:y_coordinate) || 0
  end

  def pawn_image(move)
    direc = move.try(:move_direction) || 'north'
    color = move.try(:pawn_color) || 'white'
    color == 'white' ? "#{direc}_white_pawn.png" : "#{direc}_black_pawn.png"
  end

  def pawn_placed?(move)
    move.try(:placed?)
  end

  def pawn_moved_once?(move)
    move.try(:moved_once?)
  end

  def move_direc(move)
    %w[north east].include?(move.move_direction) ? '+' : '-'
  end

  def y_axis?(move)
    move.try(:move_direction) == 'north' || move.try(:move_direction) == 'south'
  end

  def move_coordinate(move)
    return 'move[y_coordinate]' if y_axis?(move)

    'move[x_coordinate]'
  end

  def left_of
    { north: 'west', west: 'south', south: 'east', east: 'north' }
  end

  def right_of
    { north: 'east', east: 'south', south: 'west', west: 'north' }
  end

  def build_message_log(move_type, previous_move, coordinate_type)
    case move_type
    when 'LEFT' then 'LEFT'
    when 'RIGHT' then 'RIGHT'
    when 'MOVE' then "MOVE #{(previous_move.send(coordinate_type.keys[0]) - coordinate_type.values[0].to_i).abs}"
    else
      'Invalid Move'
    end
  end
end
