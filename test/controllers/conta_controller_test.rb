require 'test_helper'

class ContaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contum = conta(:one)
  end

  test "should get index" do
    get conta_url
    assert_response :success
  end

  test "should get new" do
    get new_contum_url
    assert_response :success
  end

  test "should create contum" do
    assert_difference('Contum.count') do
      post conta_url, params: { contum: { cadastro: @contum.cadastro, referencia: @contum.referencia, tipo_conta_id: @contum.tipo_conta_id, valor: @contum.valor, vencimento: @contum.vencimento } }
    end

    assert_redirected_to contum_url(Contum.last)
  end

  test "should show contum" do
    get contum_url(@contum)
    assert_response :success
  end

  test "should get edit" do
    get edit_contum_url(@contum)
    assert_response :success
  end

  test "should update contum" do
    patch contum_url(@contum), params: { contum: { cadastro: @contum.cadastro, referencia: @contum.referencia, tipo_conta_id: @contum.tipo_conta_id, valor: @contum.valor, vencimento: @contum.vencimento } }
    assert_redirected_to contum_url(@contum)
  end

  test "should destroy contum" do
    assert_difference('Contum.count', -1) do
      delete contum_url(@contum)
    end

    assert_redirected_to conta_url
  end
end
