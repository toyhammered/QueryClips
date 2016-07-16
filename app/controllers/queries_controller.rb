class QueriesController < ApplicationController
  def index
    @saved_queries = SavedQuery.all
    load_all_database_connections
  end

  def new
  end

  def run
    load_query
    load_database_connection
    load_all_database_connections
    run_query(format: :html)
  end

  def create
    @saved_query = SavedQuery.create!(
      name: params[:name],
      query: params[:query],
      database_connection_id: params[:database_connection_id]
    )
    redirect_to query_path(@saved_query)
  end

  def show
    find_query
    @query = @saved_query.query
    @database_connection = @saved_query.database_connection
    
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
    if @saved_query.destroy
      flash[:notice] = "Deleted saved query."
      redirect_to queries_path
    else
      flash[:error] = "Unable to delete saved query."
      redirect_to query_path(@saved_query)
    end
  end

  def update
    find_query
    @updated_query = params[:query]
    if @saved_query.update_attributes!(query: @updated_query)
      flash[:notice] = "Updated."
    else
      flash[:error] = "Error saving query."
    end
    redirect_to query_path(@saved_query)
  end

  private

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
      query: @query,
      database_connection: @database_connection
    )

    case format
    when :html
      result_obj = query_runner.run(:raw)
      @result = result_obj[:raw]
      @result_json = result_obj[:json]
    when :csv
      result_obj = query_runner.run(:csv)
      @result_csv = result_obj[:csv]
    when :json
      result_obj = query_runner.run(:json)
      @result_json = result_obj[:json]
    end

    @result
  rescue PG::Error => e
    @error = e
  end

  def load_all_database_connections
    @database_connections = DatabaseConnection.all
  end
end
