# frozen_string_literal: true

class CreateSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :slots do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
