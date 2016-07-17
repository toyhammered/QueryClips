class BaseDialect
  def initialize(options = {})
    @database_connection = options[:database_connection]
    @query = options[:query]

    raise "No database connection specified." if @database_connection.nil?
    raise "No query specified." if @query.nil?
  end

  def run(format)
    result = nil

    case format
    when :raw
      result = normal_query(@query)
    when :json
      result = json_query(@query)
    when :csv
      result = csv_query(@query)
    end
    
    raise "Result was nil. Check your format: #{format}" if result.nil?
    result
  end
end
