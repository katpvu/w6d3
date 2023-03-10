class CommentsController < ApplicationController

    def index
        if params[:user_id]
            #How do we know what to return? Artworks by user_id or the shared artworks with user_id?
            # render json: Artwork.artworks_for_user_id(params[:user_id])[0]
            #shares = User.joins(:shared_artworks).where(artwork_shares: {viewer_id: params[:user_id]})
            render json: Comment.comments_from_user_id(params[:user_id])
        elsif params[:artwork_id]
            render json: Comment.comments_on_artwork_id(params[:artwork_id])
        else
            artworks = Comment.all 
            render json: artworks
        end
    end

    def create
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment
        else
            render json: comment.errors.full_messages, status: :unprocessable_entity #422
        end
    end

    def destroy
		incoming_wildcard = params[:id]
		comment = Comment.find(incoming_wildcard)
		comment.destroy
        redirect_to comments_url
	end

    private
    def comment_params
        params.require(:comment).permit(:commenter_id, :artwork_id, :body)
    end

end