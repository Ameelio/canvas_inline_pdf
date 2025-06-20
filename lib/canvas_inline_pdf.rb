# frozen_string_literal: true

#
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
require "canvas_inline_pdf/version"

require "canvas_inline_pdf/plugin"
require "canvas_inline_pdf/preview"

# Canvas Plugin to render PDFS inline.
module CanvasInlinePdf
  extend Preview
  extend Plugin

  # :nocov:
  if defined?(Rails)
    # This registers the plugin and adds a callback to FilePreviewsController
    # It also adds the plugin_settings partial to the view path.
    # @see https://edgeapi.rubyonrails.org/classes/Rails/Engine.html
    class Engine < ::Rails::Engine

      config.to_prepare do
        CanvasInlinePdf.register_plugin
      end
    end
  end
  # :nocov:

  private_constant :Plugin
  private_constant :Preview
end
