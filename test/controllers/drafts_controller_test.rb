require 'test_helper'

class DraftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @law = laws(:one)
    @draft = drafts(:one)
  end

  test "should get index" do
    get law_drafts_url(@law)
    assert_response :success
  end

  test "should get new" do
    get new_law_draft_url(@law)
    assert_response :success
  end

  test "should create draft" do
    assert_difference('Draft.count') do
      post law_drafts_url(@law), params: { draft: { document_id: @draft.document_id, published_at: @draft.published_at } }
    end

    assert_redirected_to law_draft_url(@law, Draft.last)
  end

  test "should show draft" do
    get law_draft_url(@law, @draft)
    assert_response :success
  end

  test "should get edit" do
    get edit_law_draft_url(@law, @draft)
    assert_response :success
  end

  test "should update draft" do
    patch law_draft_url(@law, @draft), params: { draft: { document_id: @draft.document_id, published_at: @draft.published_at } }
    assert_redirected_to law_draft_url(@law, @draft)
  end

  test "should destroy draft" do
    assert_difference('Draft.count', -1) do
      delete law_draft_url(@law, @draft)
    end

    assert_redirected_to law_drafts_url(@law)
  end
end
