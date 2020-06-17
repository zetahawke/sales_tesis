require "application_system_test_case"

class AcceptanceCriteriaTest < ApplicationSystemTestCase
  setup do
    @acceptance_criterium = acceptance_criteria(:one)
  end

  test "visiting the index" do
    visit acceptance_criteria_url
    assert_selector "h1", text: "Acceptance Criteria"
  end

  test "creating a Acceptance criterium" do
    visit acceptance_criteria_url
    click_on "New Acceptance Criterium"

    fill_in "Criteria", with: @acceptance_criterium.criteria
    fill_in "Criteria value", with: @acceptance_criterium.criteria_value
    fill_in "Name", with: @acceptance_criterium.name
    click_on "Create Acceptance criterium"

    assert_text "Acceptance criterium was successfully created"
    click_on "Back"
  end

  test "updating a Acceptance criterium" do
    visit acceptance_criteria_url
    click_on "Edit", match: :first

    fill_in "Criteria", with: @acceptance_criterium.criteria
    fill_in "Criteria value", with: @acceptance_criterium.criteria_value
    fill_in "Name", with: @acceptance_criterium.name
    click_on "Update Acceptance criterium"

    assert_text "Acceptance criterium was successfully updated"
    click_on "Back"
  end

  test "destroying a Acceptance criterium" do
    visit acceptance_criteria_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Acceptance criterium was successfully destroyed"
  end
end
