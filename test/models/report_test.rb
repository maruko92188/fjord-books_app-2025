# frozen_string_literal: true

require 'test_helper'

MENTION_URI = 'http://localhost:3000/reports'

class ReportTest < ActiveSupport::TestCase
  test '#editable?(target_user)' do
    report_by_alice = reports(:posted_by_alice)
    alice = users(:alice)
    bob = users(:bob)

    assert report_by_alice.editable?(alice)
    assert_not report_by_alice.editable?(bob)
  end

  test '#created_on' do
    report = Report.new(created_at: Time.zone.local(2016, 10, 4))

    assert_equal Date.new(2016, 10, 4), report.created_on
  end

  test '#save_mentions 言及先のある日報を新規作成した' do
    report = Report.create!(
      user: users(:alice),
      title: 'My second report',
      content: "I refered to #{MENTION_URI}/#{reports(:posted_by_bob).id}"
    )

    assert_includes report.mentioning_reports, reports(:posted_by_bob)
  end

  test '#save_mentions 作成した日報と言及先の日報のidが同じ' do
    report = reports(:posted_by_alice)
    report.update!(content: "Refered to own report #{MENTION_URI}/#{report.id}")

    assert_not_includes report.mentioning_reports, report
  end

  test '#save_mentions 言及先の日報が変わる' do
    report = Report.new(
      user: users(:alice),
      title: 'My third report',
      content: "I refered to #{MENTION_URI}/#{reports(:posted_by_bob).id}"
    )
    report.update!(content: "I refered to #{MENTION_URI}/#{reports(:posted_by_carol).id}")

    assert_includes report.mentioning_reports, reports(:posted_by_carol)
    assert_not_includes report.mentioning_reports, reports(:posted_by_bob)
  end

  test '#save_mentions 日報が削除されると言及がなくなる' do
    report = Report.create!(
      user: users(:alice),
      title: 'My third report',
      content: "I refered to #{MENTION_URI}/#{reports(:posted_by_bob).id}"
    )

    assert_includes report.mentioning_reports, reports(:posted_by_bob)

    reports(:posted_by_bob).destroy!
    report.reload

    assert_not_includes report.mentioning_reports, reports(:posted_by_bob)
  end
end
