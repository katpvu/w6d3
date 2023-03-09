class ArtworkSharesController < ApplicationController

    def create
        shares = ArtworkShare.new(artwork_share_params)
        if shares.save
            render json: shares
        else
            render json: shares.errors.full_messages, status: :unprocessable_entity #422
        end
    end

    def destroy
		incoming_wildcard = params[:id]
		shares = ArtworkShare.find(incoming_wildcard)
		shares.destroy
        render json: shares
        # redirect_to artwork_share_url
	end

    private
	def artwork_share_params
		params.require(:artwork_share).permit(:artwork_id, :viewer_id)
    end
end