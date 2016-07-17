class MysqlDialect < BaseDialect
  def normal_query(query)
    client = Mysql2::Client.new(
      username: @database_connection.user,
      password: @database_connection.password,
      database: @database_connection.dbname,
      host: @database_connection.host,
      port: @database_connection.port
    )
    mysql_results(client.query(query))
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

  def mysql_results(mysqlresult)
    # See https://github.com/brianmario/mysql2 for format
    rows = []
    mysqlresult.each(as: :array) {|r| rows << r}
    {
      fields: mysqlresult.fields,
      rows: rows
    }
  end
end
