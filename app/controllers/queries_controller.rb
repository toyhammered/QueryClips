class QueriesController < ApplicationController
  before_filter :authorize
  
  def index
    @saved_queries = SavedQuery.all
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
      flash[:error] = "There was a problem saving your query."
      render :new
    end
  end

  def show
    find_query
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
    load_all_database_connections
    if @saved_query.update_attributes(query_params)
      flash[:notice] = "Updated."
      redirect_to query_path(@saved_query)
    else
      render :show
    end
  end

  private

  def query_params
    params.permit(:name, :query, :database_connection_id)
  end
  
  def load_query
    @query = params[:query]
  end

  def find_query
    @query_id = params[:id]
    @saved_query = SavedQuery.friendly.find(@query_id)
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
      @result_json = query_runner.run(@saved_query, :json)
    end

    @result
  rescue QueryException => e
    @error = e
  end

  def load_all_database_connections
    @database_connections = DatabaseConnection.all
  end
end
