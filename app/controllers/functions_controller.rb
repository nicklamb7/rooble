class FunctionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :set_function, only: %i[ show edit update destroy ]

  # GET /functions or /functions.json
  def index
    # @functions = Function.all
    @functions = policy_scope(Function)

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
  end

  # GET /functions/1 or /functions/1.json
  def show
  end

  # GET /functions/new
  def new
    @function = Function.new
    authorize @function
  end

  # GET /functions/1/edit
  def edit
  end

  # POST /functions or /functions.json
  def create
    @function = Function.new(function_params)
    @function.user = current_user

    respond_to do |format|
      if @function.save
        format.html { redirect_to @function, notice: "Function was successfully created." }
        format.json { render :show, status: :created, location: @function }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @function.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /functions/1 or /functions/1.json
  def update
    respond_to do |format|
      if @function.update(function_params)
        format.html { redirect_to @function, notice: "Function was successfully updated." }
        format.json { render :show, status: :ok, location: @function }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @function.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /functions/1 or /functions/1.json
  def destroy
    @function.destroy
    respond_to do |format|
      format.html { redirect_to functions_url, notice: "Function was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_function
      @function = Function.find(params[:id])
      authorize @function
    end

    # Only allow a list of trusted parameters through.
    def function_params
      params.require(:function).permit(:name, :description, :example, :type_id)
    end
end
