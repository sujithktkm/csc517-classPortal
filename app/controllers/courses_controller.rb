class CoursesController < ApplicationController
  skip_before_action :require_userauth
  before_action :require_userauth

  def show

  end

end
