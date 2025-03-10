# frozen_string_literal: true

# Migration
class AddCanvasPlugin < ActiveRecord::Migration[7.2]
  def change
    create_table :canvas_plugins, id: :string do |t|
      t.string :tag, null: false
      t.string :meta, null: false
      t.boolean :enabled
    end
  end
end
