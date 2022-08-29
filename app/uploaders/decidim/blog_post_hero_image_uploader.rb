# frozen_string_literal: true

module Decidim
  # This class deals with uploading hero images to ParticipatoryProcesses.
  class BlogPostHeroImageUploader < RecordImageUploader
    set_variants do
      { 
        small: { gravity: 'Center', resize: '300x200^', crop: '300x200+0+0' }, 
        medium: { gravity: 'Center', resize: '600x400^', crop: '600x400+0+0' }, 
        large: { gravity: 'Center', resize: '1280x854^', crop: '1280x854+0+0' } 
      }
    end
  end
end