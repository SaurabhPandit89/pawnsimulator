# frozen_string_literal: true

# class to generate chess board
class BoardsController < ApplicationController
  def index
    @move = Move.first
  end
end
