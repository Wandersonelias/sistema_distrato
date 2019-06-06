require 'test_helper'

class ReparosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reparo = reparos(:one)
  end

  test "should get index" do
    get reparos_url
    assert_response :success
  end

  test "should get new" do
    get new_reparo_url
    assert_response :success
  end

  test "should create reparo" do
    assert_difference('Reparo.count') do
      post reparos_url, params: { reparo: { descricao: @reparo.descricao, valor: @reparo.valor } }
    end

    assert_redirected_to reparo_url(Reparo.last)
  end

  test "should show reparo" do
    get reparo_url(@reparo)
    assert_response :success
  end

  test "should get edit" do
    get edit_reparo_url(@reparo)
    assert_response :success
  end

  test "should update reparo" do
    patch reparo_url(@reparo), params: { reparo: { descricao: @reparo.descricao, valor: @reparo.valor } }
    assert_redirected_to reparo_url(@reparo)
  end

  test "should destroy reparo" do
    assert_difference('Reparo.count', -1) do
      delete reparo_url(@reparo)
    end

    assert_redirected_to reparos_url
  end
end
