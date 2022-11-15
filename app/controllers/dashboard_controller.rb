class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @task_today = current_user.tasks.all.where(date:Date.today).order(time: :asc)
    @article_names = @task_today.map {|task| task.category.category}

    @hours = Time.now.strftime("%H").to_i

    @q = @task_today.ransack(params[:q])
    @tasks_today = @q.result(distinct: true)

  end
end
