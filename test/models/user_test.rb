# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = users(:alice)
    no_name_user = users(:no_name_user)

    assert_equal 'Alice', user.name_or_email
    assert_equal 'no_name_user@example.com', no_name_user.name_or_email
  end
end
