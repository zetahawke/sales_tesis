require "application_system_test_case"

class SatisfactionQuestionariesTest < ApplicationSystemTestCase
  setup do
    @satisfaction_questionary = satisfaction_questionaries(:one)
  end

  test "visiting the index" do
    visit satisfaction_questionaries_url
    assert_selector "h1", text: "Satisfaction Questionaries"
  end

  test "creating a Satisfaction questionary" do
    visit satisfaction_questionaries_url
    click_on "New Satisfaction Questionary"

    fill_in "Questions", with: @satisfaction_questionary.questions
    fill_in "Visit", with: @satisfaction_questionary.visit_id
    click_on "Create Satisfaction questionary"

    assert_text "Satisfaction questionary was successfully created"
    click_on "Back"
  end

  test "updating a Satisfaction questionary" do
    visit satisfaction_questionaries_url
    click_on "Edit", match: :first

    fill_in "Questions", with: @satisfaction_questionary.questions
    fill_in "Visit", with: @satisfaction_questionary.visit_id
    click_on "Update Satisfaction questionary"

    assert_text "Satisfaction questionary was successfully updated"
    click_on "Back"
  end

  test "destroying a Satisfaction questionary" do
    visit satisfaction_questionaries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Satisfaction questionary was successfully destroyed"
  end
end
