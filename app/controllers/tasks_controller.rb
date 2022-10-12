class TasksController < ApplicationController
    before_action :get_category
    def index
        @tasks = @category.tasks
       
    end

    def new
        @task = @category.tasks.build
    end

    def edit
        @task = Task.find(params[:id])
      end
    def update
        @task = @category.tasks.find(params[:id])
        if @task.update(task_params)
          redirect_to category_tasks_path
        end
    end

    def create
        @task = @category.tasks.build(task_params)
        if @task.save
            redirect_to category_tasks_path
        else
            render :new
        end
    end
    def show
        @task = @category.tasks.find(params[:id])
    end

    def delete
        @task = @category.tasks.find(params[:id])
        @task.destroy
        redirect_to category_tasks_path
    end

    private

    def get_category
        @category = Category.find(params[:category_id])
    end

    def task_params
        params.require(:task).permit(:task_name, :category_id, :schedule, :date, :time)
    end
        
end
