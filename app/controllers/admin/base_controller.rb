class Admin::BaseController < ApplicationController
  before_action :set_admin_sidebar

  def set_admin_sidebar
    @admin_sidebar = true
  end
end
