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
      username: @database_connection.user,
      password: @database_connection.password,
      database: @database_connection.dbname,
      host: @database_connection.host,
      port: @database_connection.port
    )
  end
end
