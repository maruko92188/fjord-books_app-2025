# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_own_comment, only: %i[edit update destroy]

  def edit; end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    @comment.save
    redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
  end

  def update
    @comment.update(comment_params)
    redirect_to @commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
  end

  def destroy
    @comment.destroy!
    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_own_comment
    @comment = current_user.comments.find(params.expect(:id))
  end

  def comment_params
    params.expect(comment: [:body])
  end
end
