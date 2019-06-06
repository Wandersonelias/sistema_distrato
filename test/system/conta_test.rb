require "application_system_test_case"

class ContaTest < ApplicationSystemTestCase
  setup do
    @contum = conta(:one)
  end

  test "visiting the index" do
    visit conta_url
    assert_selector "h1", text: "Conta"
  end

  test "creating a Contum" do
    visit conta_url
    click_on "New Contum"

    fill_in "Cadastro", with: @contum.cadastro
    fill_in "Referencia", with: @contum.referencia
    fill_in "Tipo conta", with: @contum.tipo_conta_id
    fill_in "Valor", with: @contum.valor
    fill_in "Vencimento", with: @contum.vencimento
    click_on "Create Contum"

    assert_text "Contum was successfully created"
    click_on "Back"
  end

  test "updating a Contum" do
    visit conta_url
    click_on "Edit", match: :first

    fill_in "Cadastro", with: @contum.cadastro
    fill_in "Referencia", with: @contum.referencia
    fill_in "Tipo conta", with: @contum.tipo_conta_id
    fill_in "Valor", with: @contum.valor
    fill_in "Vencimento", with: @contum.vencimento
    click_on "Update Contum"

    assert_text "Contum was successfully updated"
    click_on "Back"
  end

  test "destroying a Contum" do
    visit conta_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Contum was successfully destroyed"
  end
end
