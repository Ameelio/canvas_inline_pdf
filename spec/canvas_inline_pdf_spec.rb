# frozen_string_literal: true

require "spec_helper"
require "support/mock_attachment"
require "support/mock_plugin"

RSpec.describe CanvasInlinePdf do
  it "has a version number" do
    expect(CanvasInlinePdf::VERSION).not_to be nil
  end

  describe ".override_file_preview?" do
    it "should be able to override if both enabled and override_file_preview are true" do
      mock_plugin = MockPlugin.new(true, "true")

      allow(Canvas::Plugin).to receive(:find) { mock_plugin }
      expect(CanvasInlinePdf.override_file_preview?).to be(true)
    end

    it "should not be able to override if override_file_preview is false" do
      mock_plugin = MockPlugin.new(true, false)

      allow(Canvas::Plugin).to receive(:find) { mock_plugin }
      expect(CanvasInlinePdf.override_file_preview?).to be(false)
    end

    it "should not be able to override if disabled" do
      mock_plugin = MockPlugin.new(false, true)

      allow(Canvas::Plugin).to receive(:find) { mock_plugin }
      expect(CanvasInlinePdf.override_file_preview?).to be(false)
    end

    it "should not be able to override if nil" do
      allow(Canvas::Plugin).to receive(:find) { nil }
      expect(CanvasInlinePdf.override_file_preview?).to be(nil)
    end
  end

  describe ".previewable?" do
    it "should return false when the attachment is nil" do
      expect(CanvasInlinePdf.previewable?(nil, nil)).to be false
    end

    context "when plugin is enabled" do
      before do
        mock_plugin = MockPlugin.new(true, true)

        allow(Canvas::Plugin).to receive(:find) { mock_plugin }
      end

      it "should return false when the attachment is not pdf" do
        attachment = MockAttachment.new("application/javascript", "https://www.example.com")

        expect(CanvasInlinePdf.previewable?(nil, attachment)).to be false
      end

      it "should return true when the attachment is pdf" do
        attachment = MockAttachment.new("application/pdf", "https://www.example.com")

        expect(CanvasInlinePdf.previewable?(nil, attachment)).to be true
      end
    end

    context "when the plugin is disabled" do
      it "should return false when the attachment is not pdf" do
        attachment = MockAttachment.new("application/javascript", "https://www.example.com")

        expect(CanvasInlinePdf.previewable?(nil, attachment)).to be false
      end

      it "should return false even when the attachment is pdf" do
        attachment = MockAttachment.new("application/pdf", "https://www.example.com")

        expect(CanvasInlinePdf.previewable?(nil, attachment)).to be false
      end
    end
  end

  describe ".register_plugin" do
    let(:cfg) do
      {
        author: "Ameelio",
        description: proc { I18n.t(:description, "Canvas LMS Plugin to allow inline file preview for PDFS.") },
        name: proc { I18n.t(:name, "Inline PDF") },
        hide_from_users: false,
        settings_partial: "canvas_inline_pdf/plugin_settings",
        settings: {
          override_file_preview: false
        },
        version: CanvasInlinePdf::VERSION
      }
    end

    it "should integrate with canvas" do
      expect(Canvas::Plugin).to(receive(:register).and_return(true).once)
      expect(FilePreviewsController).to(receive(:before_action).and_return(true).once)
      CanvasInlinePdf.register_plugin
    end
  end
end
