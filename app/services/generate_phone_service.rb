class GeneratePhoneService

  def self.call(phone_params)
    params_hash = phone_params.to_h.symbolize_keys
    new(params_hash).call
  end

  def initialize(user_name:, phone: nil)
    @user_name = user_name
    @phone = Phone.convert_to_integer(phone)
  end

  def call
    User.find_or_create_by(name: user_name).phones.create(phone: pick_phone, is_custom: custom_phone?)
  end

  private

  attr_reader :user_name, :phone

  def pick_phone
    return phone if custom_phone?

    last_non_custom_phone = Phone.where(is_custom: false).last
    return Phone::START_PHONE unless last_non_custom_phone

    find_next_phone(last_non_custom_phone.phone)
  end

  def find_next_phone(phone_number)
    i = 1
    next_phone = phone_number + i
    until User.find_or_create_by(name: user_name).phones.new(phone: next_phone).valid?
      next_phone = phone_number + i
      i += 1
    end

    next_phone
  end

  def custom_phone?
    phone.present? && User.find_or_create_by(name: user_name).phones.new(phone: phone).valid?
  end
end