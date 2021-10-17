class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :index ]

  def index
    @functions = policy_scope(Function)
    @types = policy_scope(Type).sort

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'functions/list', locals: { functions: @functions }, formats: [:html] }
    end

    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query OR example ILIKE :query"
      @functions = Function.where(sql_query, query: "%#{params[:query]}%")
    else
      @functions = Function.all
    end

    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      @types = Type.where(sql_query, query: "%#{params[:query]}%")
    else
      @types = Type.all
    end
  end

  def home
    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query OR example ILIKE :query"
      @functions = Function.where(sql_query, query: "%#{params[:query]}%")
    else
      @functions = Function.all
    end
  end
end
