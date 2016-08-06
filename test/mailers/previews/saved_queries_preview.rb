class SavedQueriesPreview < ActionMailer::Preview
  def simple
    @saved_query = SavedQuery.first
    SavedQueries.simple(@saved_query, @saved_query.user.email)
  end
end
