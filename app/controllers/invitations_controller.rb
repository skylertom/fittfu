class InvitationsController < ApplicationController
  before_filter :authenticate_user!

  def new
    authorize Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.code = SecureRandom.uuid
    @invitation.invitor_id = current_user.id
    authorize @invitation
    if @invitation.save
      UserMailer.invite_email(@invitation).deliver_later
      flash[:success] =  "Sent invitation to #{@invitation.email} to be a #{@invitation.authority}"
      redirect_to invitations_path
    else
      flash[:error] =  "Error: could not create invitation"
      redirect_to root_path
    end
  end

  def index
    @invitations = Invitation.all
  end

  def destroy
    @invitation = Invitation.find_by(id: params[:id])
    authorize @invitation
    if @invitation
      @invitation.destroy
    else
      flash[:error] = "Could not find invitation with id: #{params[:id]}"
    end
    redirect_to invitations_path
  end

  private
  
  def invitation_params
    params.require(:invitation).permit(:authority, :code, :invited_by, :email)
  end
end
