require 'test_helper'

class WorkSessionsControllerTest < ActionController::TestCase
  test '#create succeeds' do
    post :create, params: {work_session: {}}, xhr: true
    assert_response :success
  end

  test '#create persists a new work session to database' do
    assert_difference 'WorkSession.count', 1 do
      post :create, params: {work_session: {}}, xhr: true
    end
  end

  test '#create persists a new day to database' do
    assert_difference 'Day.count', 1 do
      post :create, params: {work_session: {}}, xhr: true
    end
  end

  test '#create adds work session to day' do
    post :create, params: {work_session: {}}, xhr: true
    assert_equal Day.last.id, WorkSession.last.day_id
  end

  test '#create adds work session to last day if it exists' do
    day = Day.current_or_create
    post :create, params: {work_session: {}}, xhr: true
    assert_equal Day.last.id, WorkSession.last.day_id
  end

  test '#create does not persist a new work session if one is open' do
    WorkSession.current_or_create
    assert_no_difference 'WorkSession.count' do
      post :create, params: {work_session: {}}, xhr: true
    end
  end

  test '#update succeeds for empty work_session' do
    work_session = WorkSession.current_or_create
    patch :update, params: {id: work_session.id, work_session: {}}, xhr: true
    assert_response :success
  end

  test '#update sets ending time on empty work_session' do
    work_session = WorkSession.current_or_create
    patch :update, params: {id: work_session.id, work_session: {}}, xhr: true
    assert_not_nil work_session.reload.ended_at
  end

  test '#update closes last work session if "current" id specified' do
    work_session = WorkSession.current_or_create
    patch :update, params: {id: 'current', work_session: {}}, xhr: true
    assert_not_nil work_session.reload.ended_at
  end

  test '#update does not find closed work sessions' do
    assert_raises ActiveRecord::RecordNotFound do
      patch :update, params: {id: work_sessions(:full_day), work_session: {}}, xhr: true
    end
  end
end
