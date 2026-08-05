# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
