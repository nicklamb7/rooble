class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      @functions = Function.where(sql_query, query: "%#{params[:query]}%")
    else
      @functions = Function.all
    end
  end
end
