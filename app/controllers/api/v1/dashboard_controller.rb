class Api::V1::DashboardController < ApplicationController
  include AuthorizeRequest

  def show
    render json: {
      stats: {
        projects_count: @current_user.projects.count,
        tasks_count: @current_user.tasks.count,
        todo_tasks_count: @current_user.tasks.where(status: "todo").count,
        completed_tasks_count: @current_user.tasks.where(status: "done").count
      },
      recent_activities: Activity
        .where(user: @current_user)
        .includes(:project, :task)
        .order(created_at: :desc)
        .limit(10)
        .map { |activity| serialize_activity(activity) }
    }
  end

  private

  def serialize_activity(activity)
    {
      id: activity.id,
      action: activity.action,
      details: activity.details,
      created_at: activity.created_at,
      project: activity.project && {
        id: activity.project.id,
        title: activity.project.title
      },
      task: activity.task && {
        id: activity.task.id,
        title: activity.task.title
      }
    }
  end
end
