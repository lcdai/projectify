module Api
  module V1
    class TasksController < BaseController
      before_action :authenticate_user!
      before_action :set_project
      before_action :set_task, only: [:show, :update, :destroy]

      def index
        tasks = @project.tasks.order(created_at: :desc)
        tasks = tasks.where(status: params[:status]) if params[:status].present?

        render json: tasks.map { |task| task_payload(task) }
      end

      def show
        render json: task_payload(@task)
      end

      def create
        task = @project.tasks.new(task_params)
        task.user = current_user

        if task.save
          render json: task_payload(task), status: :created
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: task_payload(@task)
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @task.destroy
        head :no_content
      end

      private

      def set_project
        @project = current_user.projects.find(params[:project_id])
      end

      def set_task
        @task = @project.tasks.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :status, :priority, :due_date)
      end

      def task_payload(task)
        {
          id: task.id,
          title: task.title,
          description: task.description,
          status: task.status,
          priority: task.priority,
          due_date: task.due_date,
          project_id: task.project_id,
          created_at: task.created_at
        }
      end
    end
  end
end
