class RoomsController < ApplicationController
	before_action :authenticate_user!
  def index
    @rooms = Room.all
  end

  def show
  	@room = Room.find(params[:id])
    unless @room.password == '' || session[:room_id].include?(@room.id)
      redirect_to root_path
    end
  	@messages = Message.where(room_id: @room.id).order('id desc')
    gon.room_id = @room.id
  end

  def create
  	room = Room.create(name: params['room_name'], password: params['room_password'])
    create_session(room.id)
  	redirect_to room_path(room.id)
  end

  def destroy
  	room = Room.find(params[:id])
  	room.destroy
  	redirect_to root_path
  end

 	def message_destroy
 		message = Message.find(params[:id])
 		room = Room.find(message.room.id)
 		message.destroy
 		redirect_to room_path(room.id)
 	end

  def check_password
    room = Room.find(params['room_id'])
    if room.password != '' && session[:room_id].include?(room.id) == false
      render json: room.password
    end
  end
  # 引数はパラメータも受け取れる
  def create_session(room_id=params[:room_id].to_i)
    session[:room_id].push(room_id)
  end
end
