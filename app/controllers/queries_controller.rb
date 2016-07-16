class QueriesController < ApplicationController
  include QueriesHelper

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
    run_query(:raw)
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
        run_query(:raw)
      end
      format.json do
        run_query(:raw)
        render json: @result_json
      end
      format.csv do
        send_data run_query(:csv)
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

  def run_query(format)
    result_obj = QueryRunner.run_query(
      format: format,
      query: @query,
      database_connection: @database_connection
    )

    @result = result_obj[:result]
    if format == :raw
      @result_hash = result_obj[:hash]
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
