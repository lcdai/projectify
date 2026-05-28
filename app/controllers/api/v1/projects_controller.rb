class Api::V1::ProjectsController < ApplicationController
  include AuthorizeRequest

  before_action :set_project, only: [:show, :update, :destroy]

  def index
    projects = @current_user.projects.order(created_at: :desc)

    render json: ProjectSerializer.new(projects)
  end

  def show
    render json: ProjectSerializer.new(@project)
  end

  def create
    project = @current_user.projects.new(project_params)

    if project.save
      render json: ProjectSerializer.new(project), status: :created
    else
      render json: {
        errors: project.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: ProjectSerializer.new(@project)
    else
      render json: {
        errors: @project.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy

    render json: {
      message: "Project deleted"
    }
  end

  private

  def set_project
    @project = @current_user.projects.find(params[:id])
  end

  def project_params
    params.permit(:title, :description)
  end
end
