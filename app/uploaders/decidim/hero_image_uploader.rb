# frozen_string_literal: true

module Decidim
  # This class deals with uploading hero images to ParticipatoryProcesses.
  class HeroImageUploader < RecordImageUploader
    set_variants do
      {
        default: { resize_to_fit: [1000, 1000] },
        large: { resize_to_fit: [1440, 1440] }
      }
    end
  end
end
