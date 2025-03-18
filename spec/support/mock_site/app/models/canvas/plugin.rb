# frozen_string_literal: true

module Canvas
  class Plugin < ApplicationRecord
    self.table_name = "canvas_plugins"

    store :meta, accessors: [:settings], coder: JSON

    def self.register(name, tag, meta)
      plugin = all.where(id: name).first_or_initialize

      plugin.meta = meta
      plugin.tag = tag

      plugin.save!
    end
  end
end
