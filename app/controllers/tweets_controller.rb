class TweetsController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create]

    def index
        @tweets=Tweet.all
            if params[:search] == nil
                @tweets = params[:tag_id].present? ? Tag.find(params[:tag_id]).tweets : Tweet.all
            elsif params[:search] == ''
                @tweets = params[:tag_id].present? ? Tag.find(params[:tag_id]).tweets : Tweet.all
            else
                @tweets = Tweet.where("storename LIKE ? OR menu LIKE ? OR place LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
            end
    end

    def new
        @tweet = Tweet.new
    end
    
    def create
        tweet = Tweet.new(tweet_params)
        tweet.user_id = current_user.id
        if tweet.save!
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end

    def show
        @tweet = Tweet.find(params[:id])
    end

    private
    def tweet_params
        params.require(:tweet).permit(:name, :address, :about, :image, :tag_ids)
    end

end
