require 'test_helper'

class DaysControllerTest < ActionController::TestCase
  test '#index succeeds' do
    get :index
    assert_response :success
  end

  test '#show succeeds' do
    get :show, params: {id: 'current'}
    assert_response :success
  end

  test '#update succeeds' do
    WorkSession.current_or_create
    patch :update, params: {id: 'current', day: {}}, xhr: true
    assert_response :success
  end

  test '#update closes day' do
    WorkSession.current_or_create
    patch :update, params: {id: 'current', day: {}}, xhr: true
    assert_not Day.last.open?
  end

  test '#update closes last session on day if not closed' do
    work_session = WorkSession.current_or_create
    patch :update, params: {id: 'current', day: {}}, xhr: true
    assert_not work_session.reload.open?
  end

  test '#update sets ended_at of day to the same as last session' do
    work_session = WorkSession.current_or_create
    patch :update, params: {id: 'current', day: {}}, xhr: true
    assert_equal work_session.reload.ended_at, Day.last.ended_at
  end
end