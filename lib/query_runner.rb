class QueryRunner
  def initialize(options = {})
    @database_connection = options[:database_connection]
    @query = options[:query]

    raise "No database connection specified." if @database_connection.nil?
    raise "No query specified." if @query.nil?

    case @database_connection.dialect
    when 'PostgreSQL'
      dialect = PostgresqlDialect
    when 'MySQL'
      dialect = MysqlDialect
    else
      raise "Invalid dialect: #{@database_connection.dialect}"
    end

    @runner = dialect.new(
      database_connection: @database_connection,
      query: @query
    )
  end

  def run(format)
    @runner.run(format)
  end
end
