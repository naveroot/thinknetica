require_relative 'vendor_info'
class Wagon
  include VendorInfo

  def valid?
    validate!
  rescue StandardError
    false
  end
end
