# frozen_string_literal: true

class MockAttachment
  attr_reader :content_type

  def initialize(content_type, url)
    @content_type = content_type
    @url = url
  end

  def public_url(*)
    @url
  end
end
