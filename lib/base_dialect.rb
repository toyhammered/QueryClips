class BaseDialect
  def initialize(options = {})
    @database_connection = options[:database_connection]
    @query = options[:query]

    raise "No database connection specified." if @database_connection.nil?
    raise "No query specified." if @query.nil?
  end

  def run(format)
    result = query_with_format(format)

    return_value = {}
    case format
    when :raw, :json
      return_value[:raw] = result
      return_value[:json] = result.to_json
    when :csv
      return_value[:csv] = result
    end
    return_value
  end

  def query_with_format(format)
    result = nil

    case format
    when :raw, :json
      result = normal_query(@query)
    when :csv
      result = csv_query(@query)
    end
    
    raise "Result was nil. Check your format: #{format}" if result.nil?
    result
  end
end
