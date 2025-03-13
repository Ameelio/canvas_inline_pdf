# frozen_string_literal: true

class MockPlugin
  attr_reader :settings

  def initialize(enabled, override)
    @enabled = enabled

    @settings = {
      override_file_preview: override
    }
  end

  def enabled?
    @enabled
  end
end
