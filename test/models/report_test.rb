# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?(target_user)' do
  report_by_alice = reports(:posted_by_alice)
  alice = users(:alice)
  bob = users(:bob)

  assert report_by_alice.editable?(alice)
  assert_not report_by_alice.editable?(bob)
  end
end
