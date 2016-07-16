class QueryRunner
  def self.run_query(options = {})
    format = options[:format]
    database_connection = options[:database_connection]
    query = options[:query]

    result = query_db(query, database_connection, format)
    result_hash = result.collect { |r| r.to_h }
    return_value = {
      result: result,
      hash: result_hash,
      json: result_hash.to_json
    }
    return_value
  end

  private

  def self.query_db(query, database_connection, format)
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
