require 'byebug'

class UsersController < ApplicationController
    def index
        # debugger
        if user_params[:username]
            user = User.where(username: user_params[:username])
            render json: user
        else
            users = User.all 
            render json: users
        end
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity #422
        end
    end

    def show
        incoming_wildcard = params[:id]
		user = User.find(incoming_wildcard)
		if user
			render json: user
		else
			render json: ['not found'], status: 404
		end
    end

    def update
		incoming_wildcard = params[:id]
		user = User.find_by(id: incoming_wildcard) # id: params[:id] also works
		if user && user.update(user_params)
			redirect_to user_url(user.id)
		else
			render json: user.errors.full_messages, status: 422 #unprocessable_entity
		end
	end

    def destroy
		incoming_wildcard = params[:id]
		user = User.find(incoming_wildcard)
		user.destroy
        redirect_to users_url
	end

    private
	def user_params
		params.require(:user).permit(:username)
    end
end
