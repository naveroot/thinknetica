module VendorInfo
  attr_accessor :vendor_name

  def vendor_name
    if @vendor_name.nil?
      puts 'Производитель не указан'
    else
      puts 'Производитель: ' + vendor_name.to_s
    end
  end
end
