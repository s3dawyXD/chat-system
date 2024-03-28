class ApplicationsController < ApplicationController
  before_action :set_application, only: %i[ show update destroy ]

  # GET /applications/1
  def show
    if @application.nil?
      render json: {}, status: :not_found
    else
    render json: ApplicationSerializer.new(@application).json
    end
  end

  # POST /applications
  def create
    @application = Application.new(application_params)

    if @application.save
      render json: ApplicationSerializer.new(@application).json, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applications/1
  def update
    if @application.update(application_params)
      render json: ApplicationSerializer.new(@application).json
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1
  def destroy
    @application.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.require(:application).permit(:name)
    end
end
