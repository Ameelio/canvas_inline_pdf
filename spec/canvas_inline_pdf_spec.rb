# frozen_string_literal: true

require "spec_helper"

RSpec.describe CanvasInlinePdf do
  it "has a version number" do
    expect(CanvasInlinePdf::VERSION).not_to be nil
  end

  describe ".previewable?" do
    it "should return false when the attachment is not pdf" do
      attachment = MockAttachment.new("application/javascript", "https://www.example.com")

      expect(CanvasInlinePdf.previewable?(nil, attachment)).to be false
    end

    it "should return true when the attachment is pdf" do
      attachment = MockAttachment.new("application/pdf", "https://www.example.com")

      expect(CanvasInlinePdf.previewable?(nil, attachment)).to be true
    end
  end

  describe ".preview_url" do
    it "should return the public_url of the attachment" do
      attachment = MockAttachment.new("application/pdf", "https://www.example.com")

      expect(CanvasInlinePdf.preview_url(attachment)).to eq("https://www.example.com")
    end
  end
end
