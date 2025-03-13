# frozen_string_literal: true

class MockContext
  def self.attachments
    Attachment.all
  end

  def self.current_user
    nil
  end

  def self.read_allowed?
    true
  end

  def self.download_allowed?
    true
  end
end
