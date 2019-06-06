require "application_system_test_case"

class ReparosTest < ApplicationSystemTestCase
  setup do
    @reparo = reparos(:one)
  end

  test "visiting the index" do
    visit reparos_url
    assert_selector "h1", text: "Reparos"
  end

  test "creating a Reparo" do
    visit reparos_url
    click_on "New Reparo"

    fill_in "Descricao", with: @reparo.descricao
    fill_in "Valor", with: @reparo.valor
    click_on "Create Reparo"

    assert_text "Reparo was successfully created"
    click_on "Back"
  end

  test "updating a Reparo" do
    visit reparos_url
    click_on "Edit", match: :first

    fill_in "Descricao", with: @reparo.descricao
    fill_in "Valor", with: @reparo.valor
    click_on "Update Reparo"

    assert_text "Reparo was successfully updated"
    click_on "Back"
  end

  test "destroying a Reparo" do
    visit reparos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reparo was successfully destroyed"
  end
end
