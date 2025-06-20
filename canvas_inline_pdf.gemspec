# frozen_string_literal: true

require_relative "lib/canvas_inline_pdf/version"

Gem::Specification.new do |spec|
  spec.name = "canvas_inline_pdf"
  spec.version = CanvasInlinePdf::VERSION
  spec.authors = ["Ameelio", "Jason Kenney"]
  spec.email = ["jasonk@ameelio.org"]

  spec.description = "Canvas LMS Plugin to allow inline file preview for PDFS."
  spec.summary = "Inline PDF Plugin for Canvas LMS"
  spec.homepage = "https://github.com/Ameelio/canvas_inline_pdf"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"
  spec.metadata["github_repo"] = "ssh://github.com/Ameelio/canvas_inline_pdf"

  # Specify which files should be added to the gem when it is released.
  spec.files = %w[
    app/views/canvas_inline_pdf/_plugin_settings.html.erb
    app/views/canvas_inline_pdf/preview.html.erb
    lib/canvas_inline_pdf.rb
    lib/canvas_inline_pdf/plugin.rb
    lib/canvas_inline_pdf/plugin/attachment_extension.rb
    lib/canvas_inline_pdf/plugin/override_file_preview.rb
    lib/canvas_inline_pdf/preview.rb
    lib/canvas_inline_pdf/version.rb
    sig/canvas_inline_pdf.rbs
  ]

  spec.require_paths = ["lib"]
end
