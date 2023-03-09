require 'byebug'

class ArtworksController < ApplicationController
    def index
        if params[:user_id]
            #How do we know what to return? Artworks by user_id or the shared artworks with user_id?
            # render json: Artwork.artworks_for_user_id(params[:user_id])[0]
            #shares = User.joins(:shared_artworks).where(artwork_shares: {viewer_id: params[:user_id]})
            render json: Artwork.artworks_for_user_id(params[:user_id])
        else
            artworks = Artwork.all 
            render json: artworks
        end
    end

    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity #422
        end
    end

    def show
        incoming_wildcard = params[:id]
		artwork = Artwork.find(incoming_wildcard)
		if artwork
			render json: artwork
		else
			render json: ['not found'], status: 404
		end
    end

    def update
		incoming_wildcard = params[:id]
		artwork = Artwork.find_by(id: incoming_wildcard) # id: params[:id] also works
		if artwork && artwork.update(artwork_params)
			redirect_to artwork_url(artwork.id)
		else
			render json: artwork.errors.full_messages, status: 422 #unprocessable_entity
		end
	end

    def destroy
		incoming_wildcard = params[:id]
		artwork = Artwork.find(incoming_wildcard)
		artwork.destroy
        redirect_to artworks_url
	end

    private
	def artwork_params
		params.require(:artwork).permit(:title, :image_url, :artist_id)
    end
end