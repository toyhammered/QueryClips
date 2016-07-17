class QueryRunner
  def initialize(options = {})
    @database_connection = options[:database_connection]
    @query = options[:query]

    raise "No database connection specified." if @database_connection.nil?
    raise "No query specified." if @query.nil?

    case @database_connection.dialect
    when 'PostgreSQL'
      @runner = PostgresqlDialect.new(
        database_connection: @database_connection,
        query: @query
      )
    when 'MySQL'
      @runner = MysqlDialect.new(
        database_connection: @database_connection,
        query: @query
      )
    else
      raise "Invalid dialect: #{@database_connection.dialect}"
    end
  end

  def run(format)
    @runner.run(format)
  end

end
