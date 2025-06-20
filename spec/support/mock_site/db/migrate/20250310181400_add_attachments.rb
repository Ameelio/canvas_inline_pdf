# frozen_string_literal: true

# Migration
class AddAttachments < ActiveRecord::Migration[7.2]
  def change
    create_table :attachments do |t|
      t.string :content_type, null: false
      t.string :url, null: false
    end
  end
end
