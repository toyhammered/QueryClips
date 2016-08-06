class QueriesController < ApplicationController
  before_filter :authenticate!, except: [:show]
  before_filter :preflight_check, only: [:index, :new, :show]
  
  def index
    @saved_queries = SavedQuery.recent
    load_all_database_connections
  end

  def new
    @saved_query = SavedQuery.new
    load_all_database_connections
  end

  def create
    load_all_database_connections
    @saved_query = SavedQuery.new(query_params.merge({user_id: current_user.id}))
    if @saved_query.save
      redirect_to query_path(@saved_query)      
    else
      render :new
    end
  end

  def show
    find_query
    authorize_show!
    load_all_database_connections
        
    respond_to do |format|
      format.html do
        run_query(format: :html)
      end
      format.json do
        run_query(format: :json)
        render json: @result_json
      end
      format.csv do
        run_query(format: :csv)
        send_data @result_csv
      end
    end
  end

  def email
    @query_id = params[:query_id]
    @saved_query = SavedQuery.friendly.find(@query_id)
    authorize_show!
    load_all_database_connections
    if SavedQueries.simple(@saved_query, current_user.email).deliver
      flash[:notice] = "Your email has been sent."
      redirect_to query_path(@saved_query)
    end
  end

  def destroy
    find_query
    load_all_database_connections
    if @saved_query.destroy
      flash[:notice] = "Deleted saved query."
      redirect_to queries_path
    else
      render :show
    end
  end

  def update
    find_query
    authorize_update!
    load_all_database_connections

    if @saved_query.update_attributes(query_params)
      redirect_to query_path(@saved_query)
    else
      render :show
    end
  end

  private

  def query_params
    params.permit(:name, :query, :database_connection_id, :privacy)
  end
  
  def load_query
    @query = params[:query]
  end

  def find_query
    @query_id = params[:id]
    @saved_query = SavedQuery.friendly.find(@query_id)
  end

  def authorize_update!
    if !policy(@saved_query).edit?
      flash[:notice] = "Please log in."
      redirect_to login_path
    end
  end

  def authorize_show!
    if !policy(@saved_query).read?
      if logged_in?
        flash[:notice] = "That QueryClip is private. Please check with the owner."
        redirect_to root_path
      else
        flash[:notice] = "Please log in."
        redirect_to login_path
      end
    end
  end
  
  def load_database_connection
    @database_connection = DatabaseConnection.find(params[:database_connection_id])
  end

  def run_query(options = {})
    format = options[:format]
    raise "No format specified" if format.nil?

    query_runner = QueryRunner.new(
      database_connection: @saved_query.database_connection
    )

    case format
    when :html
      @result = query_runner.run(@saved_query.query, :raw)
      @result_json = query_runner.run(@saved_query.query, :json)
    when :csv
      @result_csv = query_runner.run(@saved_query.query, :csv)
    when :json
      @result_json = query_runner.run(@saved_query.query, :json)
    end

    @result
  rescue QueryException => e
    @error = e
  end

  def load_all_database_connections
    @database_connections = DatabaseConnection.all
  end
end
