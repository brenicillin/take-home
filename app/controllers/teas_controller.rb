class TeasController < ApplicationController
  def index
    render json: Tea.all
  end
end