# frozen_string_literal: true

# This is a mock version of the FilePreviewsController in Canvas
# to test the engine and canvas plugin integration.
class FilePreviewsController < ApplicationController
  before_action :setup

  # renders (or redirects to) appropriate content for the file, such as
  # canvadocs, crocodoc, inline image, etc.
  def show
    render plain: "original_response"
  end

  private

  def download_allowed(_attachment, _user, _session, _params)
    @context.download_allowed?
  end

  def read_allowed(_attachment, _user, _session, _params)
    @context.read_allowed?
  end

  def setup
    @context = MockContext
    @current_user = true
  end
end
