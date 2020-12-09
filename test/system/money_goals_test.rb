require "application_system_test_case"

class MoneyGoalsTest < ApplicationSystemTestCase
  setup do
    @money_goal = money_goals(:one)
  end

  test "visiting the index" do
    visit money_goals_url
    assert_selector "h1", text: "Money Goals"
  end

  test "creating a Money goal" do
    visit money_goals_url
    click_on "New Money Goal"

    fill_in "Amount", with: @money_goal.amount
    fill_in "Salesman", with: @money_goal.salesman_id
    fill_in "Type of criteria", with: @money_goal.type_of_criteria
    click_on "Create Money goal"

    assert_text "Money goal was successfully created"
    click_on "Back"
  end

  test "updating a Money goal" do
    visit money_goals_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @money_goal.amount
    fill_in "Salesman", with: @money_goal.salesman_id
    fill_in "Type of criteria", with: @money_goal.type_of_criteria
    click_on "Update Money goal"

    assert_text "Money goal was successfully updated"
    click_on "Back"
  end

  test "destroying a Money goal" do
    visit money_goals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Money goal was successfully destroyed"
  end
end
