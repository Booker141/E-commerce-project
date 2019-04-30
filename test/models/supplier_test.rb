require 'test_helper'

class SupplierTest < ActiveSupport::TestCase
  test "test_name" do
    supplier = Supplier.create(:first_name => 'John', :last_name => 'Anderson')
    assert_equal 'John Anderson', supplier.name
  end
end
