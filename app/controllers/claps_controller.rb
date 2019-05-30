class ClapsController < ApplicationController
  skip_before_action :authorized, only: [:create, :index, :destroy]

  def index
    @claps = Clap.all
    render json: @claps
  end

  def create
    @clap = Clap.create(clap_params)
    render json: @clap
  end

  def destroy
    @user_id = params[:clap][:user_id].to_i
    @post_id = params[:clap][:post_id].to_i
    puts "USERID", @user_id, @user_id.class
    puts "POSTID", @post_id, @post_id.class
    @clap = Clap.select do |c| c.user_id == @user_id && c.post_id == @post_id end
    puts 'CLAP', @clap
    @clap[0].destroy
    # redirect_back(fallback_location: root_path)
  end


  private
  def clap_params
    params.require(:clap).permit(:post_id, :user_id)
  end

end
