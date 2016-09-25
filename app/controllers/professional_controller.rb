class ProfessionalController < ApplicationController
  def index
    @user = User2.find(session[:user_id])
    @alluser = User2.all
# show all user_id that has the session_id in "network_connection_id" column with pending "status"

# Networking.where(status:'pending')
# need to change numbers to names
    @invites = Networking.where(network_connection_id:session[:user_id], status: "pending")
    # puts "==" *100
    # puts invites
    # puts params
    # puts "==" *100

    # invites.each do |invite|
    #   puts invite
    #   @invites = User2.find(invite)
    # end

    @accepted = Networking.where(network_connection_id:session[:user_id], status: "accepted")
  end

  def accepted
    # when you accept, the person that sent the request doesnt see the accepted request.....
    @accept = Networking.find_by(id: params[:id]).update(status: "accepted")

    # Networking.update(user_id:params[:id], network_connection_id: session[:user_id], status:"accepted")

    Networking.find_by(id:params[:id].to_i+ 1).update(status:"accepted")



    redirect_to '/professional/index'
  end

  def ignore
    Networking.find_by(id:params[:id]).update(status: "none")
    redirect_to '/professional/index'
  end

  def remove
    @remove = Networking.find_by(id:params[:id]).destroy
    # Networking.find_by(id:params[:id].to_i + 1).destroy
    redirect_to '/professional/index'

  end

  def logout
    reset_session
    redirect_to '/'
  end

  def show
    @alluser = User2.all
    @dontshow = Networking.pluck(:network_connection_id)

  end

  def connecting
    Networking.create(user_id:session[:user_id], network_connection_id: params[:id], status:"pending")
    Networking.create(user_id:params[:id], network_connection_id: session[:user_id], status:"sent")

    redirect_to '/professional/show'
  end

  def showUser
    @alluser = User2.find_by(id:params[:id])
    #puts @alluser
  end
end

