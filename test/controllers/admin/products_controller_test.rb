# frozen_string_literal: true

require 'test_helper'

module Admin
  class ProductsControllerTest < ActionDispatch::IntegrationTest
    test 'should get idex' do
      get admin_products_idex_url
      assert_response :success
    end

    test 'should get new' do
      get admin_products_new_url
      assert_response :success
    end

    test 'should get edit' do
      get admin_products_edit_url
      assert_response :success
    end
  end
end
