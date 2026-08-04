# frozen_string_literal: true

class Book < ApplicationRecord
  paginates_per 1
  mount_uploader :picture, PictureUploader
end
