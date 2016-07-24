class MysqlDialect < BaseDialect
  def normal_query(query)
    conn = database_connection
    format_results(conn.query(query))
  end

  def json_query(query)
    conn = database_connection
    conn.query(query).to_json
  end

  def csv_query(query)
    conn = database_connection
    results = format_results(conn.query(query))
    csv_string = CSV.generate do |csv|
      csv << results[:fields]
      results[:rows].each do |row|
        csv << row
      end
    end
    csv_string
  end

  def tables
    conn = database_connection
    query = "SELECT table_name FROM information_schema.tables WHERE table_type = 'BASE TABLE' ORDER BY table_name ASC;"
    result = format_results(conn.query(query))
    conn.close
    result
  end

  def table_schema(table)
    conn = database_connection
    query = conn.prepare("SELECT column_name, data_type, character_maximum_length FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = ?;")
    result = format_results(query.execute(table))

    # for some reason this query returns data in a different format
    result[:rows] = result[:rows].collect do |row|
      row.collect {|r| r[1]}
    end
    
    conn.close
    result
  end

  private
  
  def format_results(mysqlresult)
    # See https://github.com/brianmario/mysql2 for format
    rows = []
    mysqlresult.each(as: :array) {|r| rows << r}
    {
      fields: mysqlresult.fields,
      rows: rows
    }
  end

  def database_connection
    Mysql2::Client.new(
      username: @database_connection.username,
      password: @database_connection.password,
      database: @database_connection.dbname,
      host: @database_connection.host,
      port: @database_connection.port
    )
  end
end
