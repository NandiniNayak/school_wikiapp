class AdminController < ApplicationController
  before_action :authenticate_admin!
  def home
    @posts = Post.all
    # if params[:approve]
    #   if params[:approve] == true
    #     post.update_attribute(:approved, true)
    #   end
    # end
    # if :approve == "true"
    #   post.update_attributes(approved: true)
    # end
  end

  def approved
    @post = Post.find(params[:post])
    @post.update_attribute(:approved, true)
    redirect_to admin_home_path
  end
end
