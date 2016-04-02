module QueriesHelper
  def query_db(query, database_connection)
    # XXX move this out of rails into a service object of some kind
    conn = PG.connect(
      user: database_connection.user,
      password: database_connection.password,
      dbname: database_connection.dbname,
      host: database_connection.host,
      port: database_connection.port
    )
    result = conn.exec(query)
    result
  end
end
