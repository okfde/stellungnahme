require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @law = laws(:one)
    @comment = comments(:one)
  end

  test "should get index" do
    get law_comments_url(@law)
    assert_response :success
  end

  test "should get new" do
    get new_law_comment_url(@law)
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post law_comments_url(@law), params: { comment: { answered_at: @comment.answered_at, asked_at: @comment.asked_at, document_id: @comment.document_id, draft_id: @comment.draft_id } }
    end

    assert_redirected_to law_comment_url(@law, Comment.last)
  end

  test "should show comment" do
    get law_comment_url(@law, @comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_law_comment_url(@law, @comment)
    assert_response :success
  end

  test "should update comment" do
    patch law_comment_url(@law, @comment), params: { comment: { answered_at: @comment.answered_at, asked_at: @comment.asked_at, document_id: @comment.document_id, draft_id: @comment.draft_id } }
    assert_redirected_to law_comment_url(@law, @comment)
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete law_comment_url(@law, @comment)
    end

    assert_redirected_to law_comments_url(@law)
  end
end
