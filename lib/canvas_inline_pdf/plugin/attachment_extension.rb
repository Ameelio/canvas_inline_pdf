# frozen_string_literal: true

module CanvasInlinePdf
  module Plugin
    # Modifies the +inline_content?+ method of <tt>Attachment</tt>
    # so that Canvas will render it inline as well.
    # This is relevant for when students look at pdfs within the Modules section.
    module AttachmentExtension
      def inline_content?
        content_type == "application/pdf" || super # steep:ignore
      end
    end
  end
end
