class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @tasks_today = current_user.tasks.all.where(date:Date.today).order(time: :asc)
    @article_names = @tasks_today.map {|task| task.category.category}
  end
end
