class DatabaseConnectionController < ApplicationController
  def index
    @connections = DatabaseConnection.all
  end

  def show
    find_database_connection
  end

  def create
    name = params[:name]
    dialect = params[:dialect]
    dbname = params[:dbname]
    host = params[:host]
    port = params[:port]
    username = params[:username]
    password = params[:password]
    conn = DatabaseConnection.create!(
      name: name,
      dialect: dialect,
      dbname: dbname,
      host: host,
      port: port,
      username: username,
      password: password,
      user_id: current_user.id
    )
    redirect_to database_connection_path(conn)
  end

  def update
  end

  def destroy
    find_database_connection
    if @connection.saved_queries.count > 0
      flash[:error] = "Please remove all saved queries associated with this connection first."
      redirect_to database_connection_path(@connection)
    else
      if @connection.destroy
        flash[:notice] = "Database connection deleted."
        redirect_to database_connection_index_path
      else
        flash[:error] = "Unable to delete database connection."
        redirect_to database_connection_path(@connection)
      end
    end
  end

  def new
  end

  private

  def find_database_connection
    @connection = DatabaseConnection.find(params[:id])
  end
end
