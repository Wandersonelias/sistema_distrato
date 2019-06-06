require "application_system_test_case"

class TipoContaTest < ApplicationSystemTestCase
  setup do
    @tipo_contum = tipo_conta(:one)
  end

  test "visiting the index" do
    visit tipo_conta_url
    assert_selector "h1", text: "Tipo Conta"
  end

  test "creating a Tipo contum" do
    visit tipo_conta_url
    click_on "New Tipo Contum"

    fill_in "Descricao", with: @tipo_contum.descricao
    click_on "Create Tipo contum"

    assert_text "Tipo contum was successfully created"
    click_on "Back"
  end

  test "updating a Tipo contum" do
    visit tipo_conta_url
    click_on "Edit", match: :first

    fill_in "Descricao", with: @tipo_contum.descricao
    click_on "Update Tipo contum"

    assert_text "Tipo contum was successfully updated"
    click_on "Back"
  end

  test "destroying a Tipo contum" do
    visit tipo_conta_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tipo contum was successfully destroyed"
  end
end
