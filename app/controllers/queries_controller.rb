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
    run_query
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
    @query_id = params[:id]
    @saved_query = SavedQuery.find(@query_id)
    @query = @saved_query.query
    @database_connection = @saved_query.database_connection
    run_query
  end

  private

  def load_query
    @query = params[:query]
  end

  def load_database_connection
    @database_connection = DatabaseConnection.find(params[:database_connection_id])
  end

  def run_query
    @result = query_db(@query, @database_connection)
  rescue PG::Error => e
    @error = e
  end

  def load_all_database_connections
    @database_connections = DatabaseConnection.all
  end
end
