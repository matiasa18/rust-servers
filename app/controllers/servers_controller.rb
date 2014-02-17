class ServersController < ApplicationController
  before_action :set_server, only: [:show, :edit, :update, :destroy, :get_vote, :post_vote]
  before_filter :authenticate_user!, except: [:index, :show, :popular_servers]
  before_filter :is_mine, only: [:edit, :update]
  before_filter :set_vote, only: [:get_vote, :post_vote]

  # GET /servers
  # GET /servers.json
  def index
    @servers = Server.all
  end

  # GET /servers/1
  # GET /servers/1.json
  def show

  end

  # GET /servers/new
  def new
    @server = Server.new
  end

  # GET /servers/1/edit
  def edit
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(server_params)
    @server.user = current_user

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /servers/1
  # PATCH/PUT /servers/1.json
  def update
    respond_to do |format|
      if @server.update(server_params)
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server.destroy
    respond_to do |format|
      format.html { redirect_to servers_url }
    end
  end

  def my_servers
    @servers = Server.for_user(current_user.id).recent
  end

  def popular_servers 
    @servers = Server.all
  end

  def get_vote
    
  end

  def post_vote 
    @vote.ip = request.remote_ip
    @vote.server = @server

    respond_to do |format| 
      if verify_recaptcha && @vote.save
        format.html { 
          flash[:notice] = "You've voted for #{@server.name}!" 
          redirect_to @server 
        }
      else
        format.html { render 'get_vote' }
      end
    end
  end

  private
    def set_vote 
      @vote = Vote.new
    end

    def is_mine
      redirect_to(root_path) if @server.user_id != current_user.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.includes(:user).includes(:votes).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def server_params
      params.require(:server).permit(:name, :description, :ip)
    end
end
