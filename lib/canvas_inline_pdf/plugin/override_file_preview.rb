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
  module Plugin
    # Callback Class, used to override FilePreviewController#show
    # and use this plugin if applicable, if not - it returns controll
    # to the controller.
    #
    # This should only happen IF we have the setting turned on.
    # And, this should be removed once Canvas upstream changes their controller
    # to allow for additional plugins beyond croc and canvasdoc.
    class OverrideFilePreview
      # Runs before the FilePreviewsController#show method is called
      # If the file can be rendered inline, it will call a redirect
      # which because the controller this is modifying uses an iframe:
      # will render the pdf within the iframe.
      def before(controller)
        # Do nothing unless this setting is true.
        return unless enabled?

        context = controller.instance_variable_get(:@context)

        file = context.attachments.not_deleted.find_by(id: controller.params[:file_id])

        # Continue to the FilePreviewsController#show action.
        return unless file.present?
        return unless allowed?(controller, file)
        return unless CanvasInlinePdf.previewable?(nil, file)

        # Per Canvas: mark item seen for module progression purposes
        mark_seen(controller, file)

        url = CanvasInlinePdf.preview_url(file)

        # This will redirect (and thus cancel any remaining callbacks)
        controller.redirect_to url
      end

      private

      def allowed?(controller, file)
        current_user = controller.instance_variable_get(:@current_user)
        params       = controller.params
        session      = controller.session

        controller.send(:read_allowed, file, current_user, params, session) &&
          controller.send(:download_allowed, file, current_user, params, session)
      end

      def enabled?
        CanvasInlinePdf.override_file_preview?
      end

      def mark_seen(controller, file)
        current_user = controller.instance_variable_get(:@current_user)

        # :nocov:
        file.context_module_action(current_user, :read) if current_user
        # :nocov:

        controller.send(:log_asset_access, file, "files", "files")
      end
    end
  end
end
