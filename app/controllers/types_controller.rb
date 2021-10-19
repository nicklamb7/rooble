class TypesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :set_type, only: %i[ show edit update destroy ]

  # GET /types or /types.json
  def index
    # @types = Type.all
    @types = policy_scope(Type).sort

    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      @types = Type.where(sql_query, query: "%#{params[:query]}%")
    else
      @types = Type.all
    end
  end

  # GET /types/1 or /types/1.json
  def show
  end

  # GET /types/new
  def new
    @type = Type.new
    authorize @type
  end

  # GET /types/1/edit
  def edit
  end

  # POST /types or /types.json
  def create
    @type = Type.new(type_params)
    @type.user = current_user

    respond_to do |format|
      if @type.save
        format.html { redirect_to @type, notice: "Type was successfully created." }
        format.json { render :show, status: :created, location: @type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /types/1 or /types/1.json
  def update
    respond_to do |format|
      if @type.update(type_params)
        format.html { redirect_to @type, notice: "Type was successfully updated." }
        format.json { render :show, status: :ok, location: @type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /types/1 or /types/1.json
  def destroy
    @type.destroy
    respond_to do |format|
      format.html { redirect_to types_url, notice: "Type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type
      @type = Type.find(params[:id])
      authorize @type
    end

    # Only allow a list of trusted parameters through.
    def type_params
      params.require(:type).permit(:name, :description)
    end
end
