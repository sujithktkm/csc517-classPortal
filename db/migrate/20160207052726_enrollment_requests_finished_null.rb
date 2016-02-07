class EnrollmentRequestsFinishedNull < ActiveRecord::Migration
  def change
    change_column :enrollment_requests, :finished, :boolean, default: false, null: true
  end
end
