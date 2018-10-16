require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  test '#create succeeds' do
    post :create, params: {work_session_id: WorkSession.current_or_create.id,
                           activity: {description: Faker::GameOfThrones.quote}}, xhr: true
    assert_response :success
  end

  test '#create persists an activity to the database' do
    assert_difference 'Activity.count', 1 do
      post :create, params: {work_session_id: WorkSession.current_or_create.id,
                             activity: {description: Faker::GameOfThrones.quote}}, xhr: true
    end
  end

  test '#create persists an activity to the work sesssion' do
    work_session = WorkSession.current_or_create
    post :create, params: {work_session_id: work_session.id,
                           activity: {description: Faker::GameOfThrones.quote}}, xhr: true
    assert_equal work_session.id, Activity.last.work_session_id
  end

  test '#create does not find closed sessions' do
    assert_raises ActiveRecord::RecordNotFound do
      post :create, params: {work_session_id: work_sessions(:full_day).id,
                             activity: {description: Faker::GameOfThrones.quote}}, xhr: true
    end
  end

  test '#create adds activity to last work session "current" work session is specified' do
    work_session = WorkSession.current_or_create
    post :create, params: {work_session_id: 'current',
                           activity: {description: Faker::GameOfThrones.quote}}, xhr: true
    assert_equal work_session.id, Activity.last.work_session_id
  end

  test '#create allows user to specify description' do
    new_description = Faker::GameOfThrones.quote
    post :create, params: {work_session_id: WorkSession.current_or_create,
                           activity: {description: new_description}}, xhr: true
    assert_equal new_description, Activity.last.description
  end

  test '#update succeeds' do
    patch :update, params: {
        id: activities(:regular_work).id,
        activity: {description: Faker::GameOfThrones.quote}},
          xhr: true
    assert_response :success
  end

  test '#update updates description' do
    new_description = Faker::GameOfThrones.quote
    patch :update, params: {
        id: activities(:regular_work).id,
        activity: {description: new_description}},
          xhr: true
    assert_equal new_description, activities(:regular_work).reload.description
  end
end
