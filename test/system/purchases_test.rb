require "application_system_test_case"

class PurchasesTest < ApplicationSystemTestCase
  setup do
    @purchase = purchases(:one)
  end

  test "visiting the index" do
    visit purchases_url
    assert_selector "h1", text: "Purchases"
  end

  test "creating a Purchase" do
    visit purchases_url
    click_on "New Purchase"

    fill_in "Address", with: @purchase.address
    fill_in "Id product", with: @purchase.id_product
    fill_in "Id user", with: @purchase.id_user
    fill_in "Product discount", with: @purchase.product_discount
    fill_in "Product price", with: @purchase.product_price
    fill_in "Telephone", with: @purchase.telephone
    click_on "Create Purchase"

    assert_text "Purchase was successfully created"
    click_on "Back"
  end

  test "updating a Purchase" do
    visit purchases_url
    click_on "Edit", match: :first

    fill_in "Address", with: @purchase.address
    fill_in "Id product", with: @purchase.id_product
    fill_in "Id user", with: @purchase.id_user
    fill_in "Product discount", with: @purchase.product_discount
    fill_in "Product price", with: @purchase.product_price
    fill_in "Telephone", with: @purchase.telephone
    click_on "Update Purchase"

    assert_text "Purchase was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase" do
    visit purchases_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase was successfully destroyed"
  end
end
