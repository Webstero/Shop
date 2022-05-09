# frozen_string_literal: true

class CreateShippingTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_types do |t|
      t.string :name
      t.decimal :cost

      t.timestamps
    end
  end
end
