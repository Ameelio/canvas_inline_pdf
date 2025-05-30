# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PDF Previews", type: :request do
  context "when the plugin is enabled and override is turned on" do
    before do
      plugin = Canvas::Plugin.find(:canvas_inline_pdf)
      plugin.meta[:settings][:override_file_preview] = "true"
      plugin.enabled = true

      plugin.save
    end

    after do
      plugin = Canvas::Plugin.find(:canvas_inline_pdf)
      plugin.meta[:settings][:override_file_preview] = "false"
      plugin.enabled = false

      plugin.save
    end

    after(:each) do
      Attachment.connection.truncate_tables("attachments")
    end

    it "redirects to the pdf when the attachment is pdf" do
      attachment = Attachment.create!(content_type: "application/pdf", url: "https://www.example.com")

      get "/file_previews/#{attachment.id}"

      expect(response).to be_ok
    end

    it "returns to the original controller when the attachment is not pdf" do
      attachment = Attachment.create!(content_type: "application/javascript", url: "https://www.example.com")

      get "/file_previews/#{attachment.id}"

      expect(response.body).to eq("original_response")
    end

    it "returns to the original controller when the attachment does not exist" do
      get "/file_previews/1"

      expect(response.body).to eq("original_response")
    end

    it "should return to the original controller when downloads are not allowed" do
      allow(MockContext).to receive(:download_allowed?) { false }

      attachment = Attachment.create!(content_type: "application/pdf", url: "https://www.example.com")

      get "/file_previews/#{attachment.id}"

      expect(response.body).to eq("original_response")
    end

    it "should return to the original controller when reading is not allowed" do
      allow(MockContext).to receive(:read_allowed?) { false }

      attachment = Attachment.create!(content_type: "application/pdf", url: "https://www.example.com")

      get "/file_previews/#{attachment.id}"

      expect(response.body).to eq("original_response")
    end
  end

  context "when the plugin is enabled and override is turned off" do
    before do
      plugin = Canvas::Plugin.find(:canvas_inline_pdf)
      plugin.update(enabled: true)
    end

    it "does not modify the basic request and returns the original controller output" do
      get "/file_previews/0"
      expect(response.body).to eq "original_response"
    end
  end

  context "when the plugin is disabled" do
    it "does not modify the basic request and returns the original controller output" do
      get "/file_previews/0"
      expect(response.body).to eq "original_response"
    end
  end
end
