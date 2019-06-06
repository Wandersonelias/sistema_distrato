require "application_system_test_case"

class AluguelsTest < ApplicationSystemTestCase
  setup do
    @aluguel = aluguels(:one)
  end

  test "visiting the index" do
    visit aluguels_url
    assert_selector "h1", text: "Aluguels"
  end

  test "creating a Aluguel" do
    visit aluguels_url
    click_on "New Aluguel"

    fill_in "Data vencimento", with: @aluguel.data_vencimento
    fill_in "Juros", with: @aluguel.juros
    fill_in "Multa", with: @aluguel.multa
    fill_in "Periodo", with: @aluguel.periodo
    fill_in "Previsao pagamento", with: @aluguel.previsao_pagamento
    fill_in "Valor aluguel", with: @aluguel.valor_aluguel
    click_on "Create Aluguel"

    assert_text "Aluguel was successfully created"
    click_on "Back"
  end

  test "updating a Aluguel" do
    visit aluguels_url
    click_on "Edit", match: :first

    fill_in "Data vencimento", with: @aluguel.data_vencimento
    fill_in "Juros", with: @aluguel.juros
    fill_in "Multa", with: @aluguel.multa
    fill_in "Periodo", with: @aluguel.periodo
    fill_in "Previsao pagamento", with: @aluguel.previsao_pagamento
    fill_in "Valor aluguel", with: @aluguel.valor_aluguel
    click_on "Update Aluguel"

    assert_text "Aluguel was successfully updated"
    click_on "Back"
  end

  test "destroying a Aluguel" do
    visit aluguels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Aluguel was successfully destroyed"
  end
end
