# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    user = users(:alice)
    @report = reports(:posted_by_alice)
    visit root_url
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    assert_text 'ログインしました。'
  end

  test '日報を新規作成する' do
    visit reports_path
    click_on '日報の新規作成'

    assert_text '日報の新規作成'

    fill_in 'タイトル', with: '日報の新規作成'
    fill_in '内容', with: '日報を新規作成しました！'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '日報の新規作成'
    assert_text '日報を新規作成しました！'
  end

  test '日報を更新する' do
    visit report_path(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: '日報の編集'
    fill_in '内容', with: '日報を編集しました！'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '日報の編集'
    assert_text '日報を編集しました！'
  end

  test '日報を削除する' do
    visit report_path(@report)
    click_button 'この日報を削除'

    assert_text '日報が削除されました。'
  end
end
