# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    named_user = users(:alice)
    assert_equal 'Alice', named_user.name_or_email
    no_name_user = users(:no_name)
    assert_equal 'no_name@example.com', no_name_user.name_or_email
  end
end
