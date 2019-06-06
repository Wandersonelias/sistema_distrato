require 'test_helper'

class AluguelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aluguel = aluguels(:one)
  end

  test "should get index" do
    get aluguels_url
    assert_response :success
  end

  test "should get new" do
    get new_aluguel_url
    assert_response :success
  end

  test "should create aluguel" do
    assert_difference('Aluguel.count') do
      post aluguels_url, params: { aluguel: { data_vencimento: @aluguel.data_vencimento, juros: @aluguel.juros, multa: @aluguel.multa, periodo: @aluguel.periodo, previsao_pagamento: @aluguel.previsao_pagamento, valor_aluguel: @aluguel.valor_aluguel } }
    end

    assert_redirected_to aluguel_url(Aluguel.last)
  end

  test "should show aluguel" do
    get aluguel_url(@aluguel)
    assert_response :success
  end

  test "should get edit" do
    get edit_aluguel_url(@aluguel)
    assert_response :success
  end

  test "should update aluguel" do
    patch aluguel_url(@aluguel), params: { aluguel: { data_vencimento: @aluguel.data_vencimento, juros: @aluguel.juros, multa: @aluguel.multa, periodo: @aluguel.periodo, previsao_pagamento: @aluguel.previsao_pagamento, valor_aluguel: @aluguel.valor_aluguel } }
    assert_redirected_to aluguel_url(@aluguel)
  end

  test "should destroy aluguel" do
    assert_difference('Aluguel.count', -1) do
      delete aluguel_url(@aluguel)
    end

    assert_redirected_to aluguels_url
  end
end
