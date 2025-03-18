# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def log_asset_access(*)
    true
  end
end
