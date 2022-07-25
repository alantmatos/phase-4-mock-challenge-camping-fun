class SignupsController < ApplicationController
  before_action :set_signup, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_baddata



  # POST /signups
  def create
    signup = Signup.create!(signup_params)

    if signup
      render json: signup.activity, status: :created
    else
      render json: signup.errors, status: :unprocessable_entity
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signup
      @signup = Signup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def signup_params
      params.permit(:camper_id, :activity_id, :time)
    end

    def handle_baddata(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
