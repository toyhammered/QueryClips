class SavedQueries < ActionMailer::Base
  default from: ENV['MAIL_FROM_ADDRESS'] || 'noreply@queryclips.com'

  def simple(saved_query, recipient)
    @saved_query = saved_query
    begin
      query_runner = QueryRunner.new(
        database_connection: @saved_query.database_connection
      )

      @result = query_runner.run(@saved_query.query, :raw)

      @result
    rescue QueryException => e
      @error = e
    end

    @subject = @saved_query.name
    
    mail to: recipient, subject: @subject
  end
end
