class DatabaseConnectionController < ApplicationController
  def index
    @connections = DatabaseConnection.all
  end

  def show
    @connection = DatabaseConnection.find(params[:id])
  end

  def create
    name = params[:name]
    dbname = params[:dbname]
    host = params[:host]
    port = params[:port]
    user = params[:user]
    password = params[:password]
    conn = DatabaseConnection.create!(
      name: name,
      dbname: dbname,
      host: host,
      port: port,
      user: user,
      password: password
    )
    redirect_to database_connection_path(conn)
  end

  def update
  end

  def destroy
  end

  def new
  end
end
