class VisualizationsController < ApplicationController
  before_filter :authenticate!

  def new
    @visualization = Visualization.new
    @saved_queries = SavedQuery.all
  end

  def index
    @visualizations = Visualization.all
  end

  def create
    @visualization = Visualization.new
    if @visualization.update_attributes(visualization_params)
      redirect_to visualization_path(@visualization)
    else
      render :new
    end
  end

  def update
    find_visualization
    @visualization.code = params[:code]
    
    if @visualization.save
      redirect_to visualization_path(@visualization)
    else
      render :show
    end
  end

  def show
    find_visualization
    query_runner = QueryRunner.new(
      database_connection: @saved_query.database_connection
    )
    @json_data = query_runner.run(@saved_query.query, :json)
    
  end

  private

  def visualization_params
    params.require(:visualization).permit(:name, :saved_query_id)
  end
  
  def find_visualization
    @visualization = Visualization.friendly.find(params[:id])
    @saved_query = @visualization.saved_query
  end
end
