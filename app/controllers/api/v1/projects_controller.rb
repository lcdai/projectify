module Api
  module V1
    class ProjectsController < BaseController
      before_action :authenticate_user!
      before_action :set_project, only: [:show, :update, :destroy]

      def index
        projects = current_user.projects.order(created_at: :desc)

        if params[:q].present?
          projects = projects.where("name ILIKE ?", "%#{params[:q]}%")
        end

        if params[:status].present?
          projects = projects.where(status: params[:status])
        end

        render json: projects.map { |project| project_payload(project) }
      end

      def show
        render json: project_payload(@project, include_tasks: true)
      end

      def create
        project = current_user.projects.new(project_params)

        if project.save
          render json: project_payload(project), status: :created
        else
          render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @project.update(project_params)
          render json: project_payload(@project)
        else
          render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @project.destroy
        head :no_content
      end

      private

      def set_project
        @project = current_user.projects.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:name, :description, :status, :due_date)
      end

      def project_payload(project, include_tasks: false)
        payload = {
          id: project.id,
          name: project.name,
          description: project.description,
          status: project.status,
          due_date: project.due_date,
          tasks_count: project.tasks.count,
          created_at: project.created_at
        }

        if include_tasks
          payload[:tasks] = project.tasks.order(created_at: :desc).map do |task|
            {
              id: task.id,
              title: task.title,
              description: task.description,
              status: task.status,
              priority: task.priority
            }
          end
        end

        payload
      end
    end
  end
end
