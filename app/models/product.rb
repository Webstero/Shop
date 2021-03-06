# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than: 0.0 }
  validates :category, presence: true

  mount_uploader :photo, ProductPhotoUploader
  # serialize :photo, JSON

  def to_param
    "#{id}-#{name}".parameterize
  end
end
