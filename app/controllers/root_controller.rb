class RootController < ApplicationController
  def home
    @posts = Post.all
    unless current_user.nil?
      @post = current_user.posts.build
    end
  end
end
