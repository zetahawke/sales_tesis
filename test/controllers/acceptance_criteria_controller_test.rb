require 'test_helper'

class AcceptanceCriteriaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acceptance_criterium = acceptance_criteria(:one)
  end

  test "should get index" do
    get acceptance_criteria_url
    assert_response :success
  end

  test "should get new" do
    get new_acceptance_criterium_url
    assert_response :success
  end

  test "should create acceptance_criterium" do
    assert_difference('AcceptanceCriterium.count') do
      post acceptance_criteria_url, params: { acceptance_criterium: { criteria: @acceptance_criterium.criteria, criteria_value: @acceptance_criterium.criteria_value, name: @acceptance_criterium.name } }
    end

    assert_redirected_to acceptance_criterium_url(AcceptanceCriterium.last)
  end

  test "should show acceptance_criterium" do
    get acceptance_criterium_url(@acceptance_criterium)
    assert_response :success
  end

  test "should get edit" do
    get edit_acceptance_criterium_url(@acceptance_criterium)
    assert_response :success
  end

  test "should update acceptance_criterium" do
    patch acceptance_criterium_url(@acceptance_criterium), params: { acceptance_criterium: { criteria: @acceptance_criterium.criteria, criteria_value: @acceptance_criterium.criteria_value, name: @acceptance_criterium.name } }
    assert_redirected_to acceptance_criterium_url(@acceptance_criterium)
  end

  test "should destroy acceptance_criterium" do
    assert_difference('AcceptanceCriterium.count', -1) do
      delete acceptance_criterium_url(@acceptance_criterium)
    end

    assert_redirected_to acceptance_criteria_url
  end
end
