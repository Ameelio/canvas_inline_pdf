# frozen_string_literal: true

# Copyright (C) 2025 - present Ameelio
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the “Software”), to deal in the
# Software without restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
# Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require "canvas_inline_pdf/plugin/override_file_preview"

module CanvasInlinePdf
  # Canvas LMS Integration and registration.
  module Plugin
    def override_file_preview?
      Plugin.override_file_preview?
    end

    def register_plugin
      Plugin.register
    end

    spec = Gem::Specification.find_by_name("canvas_inline_pdf")

    @cfg = {
      author: spec.authors.first,
      description: spec.description,
      name: spec.summary,
      hide_from_users: false,
      settings_partial: "canvas_inline_pdf/plugin_settings",
      settings: {
        override_file_preview: false
      },
      version: spec.version
    }

    @name = :canvas_inline_pdf

    # ########################################
    # As singleton methods, these never get
    # added when include or extend are called.
    # ########################################
    def self.override_file_preview?
      plugin = Canvas::Plugin.find(@name)

      plugin&.enabled? && plugin.settings[:override_file_preview]
    end

    def self.register
      Canvas::Plugin.register(@name, :previews, @cfg)

      ::FilePreviewsController.before_action(
        OverrideFilePreview.new,
        on: :show
      )
    end
  end
end
