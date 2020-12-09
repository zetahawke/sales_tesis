require 'test_helper'

class MoneyGoalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @money_goal = money_goals(:one)
  end

  test "should get index" do
    get money_goals_url
    assert_response :success
  end

  test "should get new" do
    get new_money_goal_url
    assert_response :success
  end

  test "should create money_goal" do
    assert_difference('MoneyGoal.count') do
      post money_goals_url, params: { money_goal: { amount: @money_goal.amount, salesman_id: @money_goal.salesman_id, type_of_criteria: @money_goal.type_of_criteria } }
    end

    assert_redirected_to money_goal_url(MoneyGoal.last)
  end

  test "should show money_goal" do
    get money_goal_url(@money_goal)
    assert_response :success
  end

  test "should get edit" do
    get edit_money_goal_url(@money_goal)
    assert_response :success
  end

  test "should update money_goal" do
    patch money_goal_url(@money_goal), params: { money_goal: { amount: @money_goal.amount, salesman_id: @money_goal.salesman_id, type_of_criteria: @money_goal.type_of_criteria } }
    assert_redirected_to money_goal_url(@money_goal)
  end

  test "should destroy money_goal" do
    assert_difference('MoneyGoal.count', -1) do
      delete money_goal_url(@money_goal)
    end

    assert_redirected_to money_goals_url
  end
end
