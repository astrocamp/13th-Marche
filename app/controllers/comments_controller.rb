class CommentsController < ApplicationController
  before_action :set_product, only: [:create]
  before_action :set_product_comment, only: [:edit, :update, :destroy]
  
  def create
    @product_comment = current_user.product_comments.build(params_comment)
    @product_comment.product_id = params[:product_id]

    unless @product_comment.save
      @product_comments = ProductComment.includes(:user).order(created_at: :desc)
      redirect_to product_path(params[:product_id]), alert: "留言不能為空!"
    end
  end

  def edit
  end

  def update
    unless @product_comment.update(params_comment)
      flash[:alert] = "fail editing comment."
      render :edit
    end
  end

  def destroy
    @product_comment.destroy
  end

  private

  def params_comment
    params[:product_comment].permit(:content, :rating)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_product_comment
    @product_comment = ProductComment.find(params[:id])
  end

end
