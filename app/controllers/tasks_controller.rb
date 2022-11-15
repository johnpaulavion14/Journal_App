class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :get_category, only: %i[ index new show edit create update delete ]
    def index
        tasks = @category.tasks
        @q = tasks.ransack(params[:q])
        @tasks = @q.result(distinct: true)
       
    end

    def new
        @task = @category.tasks.build
    end

    def edit
        @task = @category.tasks.find(params[:id])
        @time = @task.time
      end
    def update
        @task = @category.tasks.find(params[:id])
        if @task.update(task_params)
          if params[:from] == "dash"
            redirect_to dashboard_index_path({from:"update"}), notice: "Task was successfully Updated."   
          elsif params[:from] == "all_tasks"
            redirect_to all_tasks_path({from:"update"}), notice: "Task was successfully Updated."             
          else
            redirect_to category_tasks_path({from:"update"}), notice: "Task was successfully Updated." 
          end
        end
    end

    def create
        @task = @category.tasks.new(task_params)
        if @task.save
            redirect_to categories_path({from:"new"}), notice: "Task was successfully Created." 
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
        if params[:from] == "dash"
            redirect_to dashboard_index_path({from:"del"}), notice: "Task was successfully Deleted."            
        elsif params[:from] == "all_tasks"
            redirect_to all_tasks_path({from:"del"}), notice: "Task was successfully Deleted."  
        else
            redirect_to category_tasks_path({from:"del"}), notice: "Task was successfully Deleted." 
        end
    end

    def new_task

    end    

    def create_new_task
        category_name = current_user.categories.pluck(:category)
        if category_name.include?(params[:category])
            category = current_user.categories.find_by(category:params[:category])
        else
            current_user.categories.create(category:params[:category])
            category = current_user.categories.last
        end
        category.tasks.create(task:params[:task], date:params[:date], time:params[:time])
        if params[:from] == "all_tasks"
            redirect_to all_tasks_path({from:"new"}), notice: "Task was successfully Created." 
        else
            redirect_to dashboard_index_path({from:"new"}), notice: "Task was successfully Created." 
        end
 
    end

    def all_tasks
        @q = current_user.tasks.all.ransack(params[:q])
        @all_tasks = @q.result(distinct: true)        
    end   

    private

    def get_category
        @category = current_user.categories.find(params[:category_id])
    end

    def task_params
        params.require(:task).permit(:task, :date, :time)
    end
        
end
