require "application_system_test_case"

class SalesmenTest < ApplicationSystemTestCase
  setup do
    @salesman = salesmen(:one)
  end

  test "visiting the index" do
    visit salesmen_url
    assert_selector "h1", text: "Salesmen"
  end

  test "creating a Salesman" do
    visit salesmen_url
    click_on "New Salesman"

    fill_in "Name", with: @salesman.name
    click_on "Create Salesman"

    assert_text "Salesman was successfully created"
    click_on "Back"
  end

  test "updating a Salesman" do
    visit salesmen_url
    click_on "Edit", match: :first

    fill_in "Name", with: @salesman.name
    click_on "Update Salesman"

    assert_text "Salesman was successfully updated"
    click_on "Back"
  end

  test "destroying a Salesman" do
    visit salesmen_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Salesman was successfully destroyed"
  end
end
