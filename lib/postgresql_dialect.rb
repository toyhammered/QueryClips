class PostgresqlDialect < BaseDialect
  def normal_query(query)
    conn = database_connection
    format_results(conn.exec(query))
  end

  def json_query(query)
    conn = database_connection
    query = query.gsub(/;/,"")
    result = conn.exec("SELECT array_to_json(array_agg(t)) FROM (#{query}) t")
    result.getvalue(0,0)
  end

  def csv_query(query)
    conn = database_connection
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

  def tables
    conn = database_connection
    query = "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE' ORDER BY table_name ASC;"
    result = format_results(conn.exec(query))
    conn.finish
    result
  end

  def table_schema(table)
    conn = database_connection
    query = "SELECT column_name, data_type, character_maximum_length FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '#{conn.escape_string(table)}';"
    result = format_results(conn.exec(query))
    conn.finish
    result
  end

  private

  def format_results(pgresult)
    # See https://deveiate.org/code/pg/PG/Result.html for format
    rows = []
    pgresult.each_row {|r| rows << r}
    {
      fields: pgresult.fields,
      rows: rows
    }
  end

  def database_connection
    PG.connect(
      user: @database_connection.user,
      password: @database_connection.password,
      dbname: @database_connection.dbname,
      host: @database_connection.host,
      port: @database_connection.port
    )
  end
end
