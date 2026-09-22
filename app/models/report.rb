# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentionings,
           class_name: 'Mention',
           foreign_key: 'mentioning_report_id',
           inverse_of: 'mentioning_report',
           dependent: :destroy

  has_many :mentioneds,
           class_name: 'Mention',
           foreign_key: 'mentioned_report_id',
           inverse_of: 'mentioned_report',
           dependent: :destroy

  has_many :mentioning_reports,
           through: :mentionings,
           source: :mentioned_report

  has_many :mentioned_reports,
           through: :mentioneds,
           source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  after_save :update_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def update_mentions
    target_ids = extract_ids
    return if previously_new_record? && target_ids.empty?
    return if mentioning_report_ids.sort == target_ids.sort

    self.mentioning_reports = Report.where(id: target_ids)
  end

  def extract_ids
    target_uri = 'http://localhost:3000/reports/'
    regexp = /#{target_uri}(\d+)/
    ids_table = content.scan(regexp)
    ids = ids_table.flatten.uniq.map(&:to_i)
    ids.delete(id)
    ids
  end
end
