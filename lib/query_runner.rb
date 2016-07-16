class QueryRunner
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
      return_value[:json] = result.collect { |r| r.to_h }.to_json
    when :csv
      return_value[:csv] = result
    end
    return_value
  end

  private
  
  def query_with_format(format)
    conn = connection_from_database_connection(@database_connection)

    result = nil

    case format
    when :raw, :json
      result = conn.exec(@query)
    when :csv
      result = csv_query(conn, @query)
    end
    
    raise "Result was nil. Check your format: #{format}" if result.nil?
    result
  end

  def csv_query(conn, query)
    query = query.gsub(/;/,"")
    data = []
    conn.copy_data("COPY (#{query}) TO STDOUT WITH (FORMAT CSV, HEADER TRUE, FORCE_QUOTE *, ESCAPE E'\\\\');") do
      while row = conn.get_copy_data
        data.push(row)
      end
    end
    data = data.join("\n")
    data
  end

  def connection_from_database_connection(database_connection)
    PG.connect(
      user: database_connection.user,
      password: database_connection.password,
      dbname: database_connection.dbname,
      host: database_connection.host,
      port: database_connection.port
    )
  end
end
