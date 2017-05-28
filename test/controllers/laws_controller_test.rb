require 'test_helper'

class LawsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @law = laws(:one)
  end

  test "should get index" do
    get laws_url
    assert_response :success
  end

  test "should get new" do
    get new_law_url
    assert_response :success
  end

  test "should create law" do
    assert_difference('Law.count') do
      post laws_url, params: { law: { id: @law.id, slug: @law.slug, title: @law.title } }
    end

    assert_redirected_to law_url(Law.last)
  end

  test "should show law" do
    get law_url(@law)
    assert_response :success
  end

  test "should get edit" do
    get edit_law_url(@law)
    assert_response :success
  end

  test "should update law" do
    patch law_url(@law), params: { law: { id: @law.id, slug: @law.slug, title: @law.title } }
    assert_redirected_to law_url(@law)
  end

  test "should destroy law" do
    assert_difference('Law.count', -1) do
      delete law_url(@law)
    end

    assert_redirected_to laws_url
  end
end
