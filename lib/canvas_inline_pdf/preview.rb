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

module CanvasInlinePdf
  # @see https://github.com/instructure/canvas-lms/blob/master/app/controllers/file_previews_controller.rb
  # @note Called by FilePreviewsController#show in Canvas LMS
  module Preview
    # Returns true if attachment is a PDF or TXT file.
    # @see https://github.com/instructure/canvas-lms/blob/master/app/models/attachment.rb
    def previewable?(_account, attachment)
      attachment&.content_type.to_s == "application/pdf"
    end

    # Redirects to the attachment's public url (If in S3 this is a signed url)
    # @see https://github.com/instructure/canvas-lms/blob/master/app/models/attachment.rb
    def preview_url(attachment)
      attachment.public_url(expires_in: 5 * 60)
    end
  end
end
