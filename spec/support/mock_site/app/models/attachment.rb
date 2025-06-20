# frozen_string_literal: true

# File attachments.
class Attachment < ApplicationRecord
  scope :not_deleted, lambda {
    all
  }

  def context_module_action(*)
    true
  end

  def public_url(*)
    url
  end

  def public_download_url(*)
    url
  end
end
