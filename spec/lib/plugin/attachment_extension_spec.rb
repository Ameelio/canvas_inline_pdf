# frozen_string_literal: true

require "spec_helper"

module CanvasInlinePdf
  module Plugin
    RSpec.describe AttachmentExtension do
      describe "#inline_content?" do
        before do
          MockAttachment.prepend(AttachmentExtension)
        end

        context "when plugin is enabled" do
          before do
            allow(CanvasInlinePdf).to receive(:enabled?) { true }
          end

          it "should return true when the content_type is pdf." do
            mock_attachment = MockAttachment.new("application/pdf", "https://www.example.com")

            expect(mock_attachment).to be_inline_content
          end

          it "should return false when the content_type is not pdf" do
            mock_attachment = MockAttachment.new("application/javascript", "https://www.example.com")

            expect(mock_attachment).not_to be_inline_content
          end
        end

        context "when plugin is disabled" do
          before do
            allow(CanvasInlinePdf).to receive(:enabled?) { false }
          end

          it "should return true when the content_type is pdf." do
            mock_attachment = MockAttachment.new("application/pdf", "https://www.example.com")

            expect(mock_attachment).not_to be_inline_content
          end

          it "should return false when the content_type is not pdf" do
            mock_attachment = MockAttachment.new("application/javascript", "https://www.example.com")

            expect(mock_attachment).not_to be_inline_content
          end
        end
      end
    end
  end
end
