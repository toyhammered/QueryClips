class QueryRunner
  def initialize(options = {})
    @database_connection = options[:database_connection]

    raise "No database connection specified." if @database_connection.nil?

    case @database_connection.dialect
    when 'PostgreSQL'
      dialect = PostgresqlDialect
    when 'MySQL'
      dialect = MysqlDialect
    else
      raise "Invalid dialect: #{@database_connection.dialect}"
    end

    @dialect = dialect.new(
      database_connection: @database_connection
    )
  end

  def run(query, format)
    @dialect.query(
      query: query,
      format: format
    )
  rescue Mysql2::Error => e
    raise QueryException.new(e)
  rescue PG::Error => e
    raise QueryException.new(e)
  end
end
