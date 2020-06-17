require 'test_helper'

class SatisfactionQuestionariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @satisfaction_questionary = satisfaction_questionaries(:one)
  end

  test "should get index" do
    get satisfaction_questionaries_url
    assert_response :success
  end

  test "should get new" do
    get new_satisfaction_questionary_url
    assert_response :success
  end

  test "should create satisfaction_questionary" do
    assert_difference('SatisfactionQuestionary.count') do
      post satisfaction_questionaries_url, params: { satisfaction_questionary: { questions: @satisfaction_questionary.questions, visit_id: @satisfaction_questionary.visit_id } }
    end

    assert_redirected_to satisfaction_questionary_url(SatisfactionQuestionary.last)
  end

  test "should show satisfaction_questionary" do
    get satisfaction_questionary_url(@satisfaction_questionary)
    assert_response :success
  end

  test "should get edit" do
    get edit_satisfaction_questionary_url(@satisfaction_questionary)
    assert_response :success
  end

  test "should update satisfaction_questionary" do
    patch satisfaction_questionary_url(@satisfaction_questionary), params: { satisfaction_questionary: { questions: @satisfaction_questionary.questions, visit_id: @satisfaction_questionary.visit_id } }
    assert_redirected_to satisfaction_questionary_url(@satisfaction_questionary)
  end

  test "should destroy satisfaction_questionary" do
    assert_difference('SatisfactionQuestionary.count', -1) do
      delete satisfaction_questionary_url(@satisfaction_questionary)
    end

    assert_redirected_to satisfaction_questionaries_url
  end
end
