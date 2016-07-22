class SchemaExplorer
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

  def tables
    @dialect.tables[:rows].collect {|r| r.first }
  end

  def table_schema(table)
    @dialect.table_schema(table)
  end
end
