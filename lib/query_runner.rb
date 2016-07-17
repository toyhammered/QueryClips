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
      return_value[:json] = result.to_json
    when :csv
      return_value[:csv] = result
    end
    return_value
  end

  private
  
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

  def normal_query(query)
    case @database_connection.dialect
    when 'PostgreSQL'
      conn = PG.connect(
        user: @database_connection.user,
        password: @database_connection.password,
        dbname: @database_connection.dbname,
        host: @database_connection.host,
        port: @database_connection.port
      )
      pg_results(conn.exec(query))
    when 'MySQL'
      client = Mysql2::Client.new(
        username: @database_connection.user,
        password: @database_connection.password,
        database: @database_connection.dbname,
        host: @database_connection.host,
        port: @database_connection.port
      )
      client.query(query)
    else
      raise "Invalid dialect: #{@database_connection.dialect}"
    end
  end

  def csv_query(query)
    conn = PG.connect(
      user: @database_connection.user,
      password: @database_connection.password,
      dbname: @database_connection.dbname,
      host: @database_connection.host,
      port: @database_connection.port
    )
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

  def pg_results(pgresult)
    rows = []
    pgresult.each_row {|r| rows << r}
    {
      fields: pgresult.fields,
      rows: rows
    }
  end
end
