class BaseDialect
  def initialize(options = {})
    @database_connection = options[:database_connection]

    raise "No database connection specified." if @database_connection.nil?
  end

  def query(options = {})
    format = options[:format]
    query = options[:query]

    raise "No query specified." if query.nil?
    raise "No format specified." if format.nil?
    
    result = nil

    case format
    when :raw
      result = normal_query(query)
    when :json
      result = json_query(query)
    when :csv
      result = csv_query(query)
    end
    
    result
  end
end
