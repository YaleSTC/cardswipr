require 'set'
require 'uri'

class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  @@max_num_users = 10

  # GET /users
  # GET /users.json
  def index
    if params[:q]
      @users = find(params[:q])
    else
      @users = User.order(:last_name, :first_name)
        .paginate(page: params[:page], per_page: 20)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users.to_json }
      format.csv { send_data @users.to_csv }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html { redirect_to edit_user_path(@user) }
      format.json { render json: User.find(params[:id]) }
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def find_users
    puts params[:query]
    users = find(URI.decode(params[:query]))
    ret_objs = []

    users.each do |user|
      ret_obj = { id: user.id, display: user.full_name_with_netid }
      ret_objs.push(ret_obj)
    end
    render json: ret_objs
  end

private

  def process_user(user)
    user.display = 'a'
  end

  def find(pattern)
    users = Set.new
    tokens = pattern.split
    return [] if tokens.size > 2

    if tokens.size == 1
      search_single(tokens[0], 'netid', users)
      search_single(tokens[0], 'nickname', users)
      search_single(tokens[0], 'first_name', users)
      search_single(tokens[0], 'last_name', users)
    else
      search_double(tokens[0], tokens[1], 'nickname', 'last_name', users)
      search_double(tokens[1], tokens[0], 'nickname', 'last_name', users)
      search_double(tokens[0], tokens[1], 'first_name', 'last_name', users)
      search_double(tokens[1], tokens[0], 'first_name', 'last_name', users)
    end
    return users.to_a.slice(0, @@max_num_users)
  end

  def search_single(token, column, users)
    max = @@max_num_users - users.size
    tmp_users = User.limit(max < 0 ? 0 : max)
      .where("lower(#{column}) like ?", token.downcase + '%')
    users.merge(tmp_users)
  end

  def search_double(token1, token2, column1, column2, users)
    pattern1 = token1 + '%'
    pattern2 = token2 + '%'
    max = @@max_num_users - users.size
    tmp_users = User.limit(max < 0 ? 0 : max)
      .where("lower(#{column1}) like ? and lower(#{column2}) like ? or " +
             "lower(#{column2}) like ? and lower(#{column1}) like ?",
             pattern1, pattern2, pattern1, pattern2)
    users.merge(tmp_users)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :nickname, :last_name, :email)
  end
end
