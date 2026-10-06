module Api
  module V1
    class ActivitiesController < BaseController
      before_action :authenticate_user!

      def index
        activities = current_user.activities.includes(:project, :task).order(created_at: :desc).limit(20)

        render json: activities.map { |activity| activity_payload(activity) }
      end

      private

      def activity_payload(activity)
        {
          id: activity.id,
          action: activity.action,
          details: activity.details,
          project_name: activity.project&.name,
          task_title: activity.task&.title,
          created_at: activity.created_at
        }
      end
    end
  end
end
