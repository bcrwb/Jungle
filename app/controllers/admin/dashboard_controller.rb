class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_USERNAME"], 
  password: ENV["HTTP_PASSWORD"],
  if: -> { ENV["HTTP_PASSWORD"].present? }
  def show
  end
end
