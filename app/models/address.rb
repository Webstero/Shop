# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :order

  validates :first_name, :last_name, :zip_code, :street, :email, :city, presence: true
end
