class PostgresqlDialect < BaseDialect
  def normal_query(query)
    conn = PG.connect(
      user: @database_connection.user,
      password: @database_connection.password,
      dbname: @database_connection.dbname,
      host: @database_connection.host,
      port: @database_connection.port
    )
    format_results(conn.exec(query))
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

  def format_results(pgresult)
    # See https://deveiate.org/code/pg/PG/Result.html for format
    rows = []
    pgresult.each_row {|r| rows << r}
    {
      fields: pgresult.fields,
      rows: rows
    }
  end

end
