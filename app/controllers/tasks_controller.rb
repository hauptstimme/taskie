class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_users, only: [ :new, :edit ]

  scaffold! permit_fields: [ :assignee_id, :name, :details, :status ]

  private

  def set_users
    @users ||= User.all.map{ |n| [ n.email, n.id ] }
  end
end
