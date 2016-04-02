module QueriesHelper
  def query_db(query, database_connection, format)
    # XXX move this out of rails into a service object of some kind
    conn = PG.connect(
      user: database_connection.user,
      password: database_connection.password,
      dbname: database_connection.dbname,
      host: database_connection.host,
      port: database_connection.port
    )

    case format
    when :raw
      conn.exec(query)
    when :csv
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
  end
end
