require 'test_helper'

class Admin::SupplierControllerTest < ActionDispatch::IntegrationTest
  fixtures :suppliers

  test "new" do
    get '/admin/supplier/new'
    assert_template 'admin/supplier/new'
    assert_select 'div#content' do
      assert_select 'h1', 'Crear nuevo proveedor'
      assert_select "form[action=\"/admin/supplier/create\"]"
    end
  end

  test "create" do
    get '/admin/supplier/new'
    assert_template 'admin/supplier/new'
    assert_difference(Supplier, :count) do
      post '/admin/supplier/create', :params => { :supplier => { :first_name => 'Jon', :last_name => 'Anderson' }}
      assert_response :redirect
      assert_redirected_to :action => 'index'      
    end
    assert_equal 'Proveedor Jon Anderson creado correctamente.', flash[:notice]
  end

  test "failing_create" do
    assert_no_difference(Supplier, :count) do
      post '/admin/supplier/create', :params => { :supplier => { :first_name => 'Jon' }}
      assert_response :success
      assert_template 'admin/supplier/new'
      assert_select "div[class=\"field_with_errors\"]"
    end
  end

  test "edit" do
    get '/admin/supplier/edit', :params => { :id => 1 }
    assert_select 'input' do
      assert_select '[type=?]', 'text'
      assert_select '[name=?]', 'supplier[first_name]'
      assert_select '[value=?]', 'Joel'
    end
    assert_select 'input' do
      assert_select '[type=?]', 'text'
      assert_select '[name=?]', 'supplier[last_name]'
      assert_select '[value=?]', 'Spolsky'
    end
  end

  test "update" do
    post '/admin/supplier/update', :params => { :id => 1, :supplier => { :first_name => 'Joseph', :last_name => 'Spolsky' }}
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'Joseph', Supplier.find(1).first_name
  end

  test "test_destroy" do
    assert_difference(Supplier, :count, -1) do
      post '/admin/supplier/destroy', :params => { :id => 1 }
      assert_equal flash[:notice], 'Proveedor Joel Spolsky eliminado correctamente.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get '/admin/supplier/index'
      assert_response :success
      assert_select 'div#notice', 'Proveedor Joel Spolsky eliminado correctamente.'
    end
  end

  test "show" do
    get '/admin/supplier/show', :params => { :id => 1 }
    assert_template 'admin/supplier/show'
    assert_equal 'Joel', assigns(:supplier).first_name
    assert_equal 'Spolsky', assigns(:supplier).last_name
    assert_select 'div#content' do
      assert_select 'h1', Supplier.find(1).name
    end
  end

  test "index" do
    get '/admin/supplier/index'
    assert_response :success
    assert_select 'table' do
      assert_select 'tr', Supplier.count + 1
    end
    Supplier.find_each do |a|
      assert_select 'td', a.name
    end
  end
end
