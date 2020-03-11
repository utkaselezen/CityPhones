class PhonesController < ApplicationController
  respond_to :json

  def new

    @phone_number = GeneratePhoneService.call(phone_params)

    respond_to do |format|
      format.json do
        render json: { user_name: phone_number.user.name, phone: Phone.stringified(phone_number.phone) }
      end
    end
  end

  def index
    @phone_number = Phone.all
    respond_to do |format|
      format.json do
        render json: {  list: @phone_number.map do |pn| { phone: pn.phone, name: pn.user.name }end }
      end
    end
  end


  private

  attr_reader :phone_number

  def phone_params
    params.permit(:phone, :user_name)
  end

end
