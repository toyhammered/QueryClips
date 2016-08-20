task :daily_digest => :environment do
  SavedQuery.daily_digest.each do |sv|
    SavedQueries.simple(sv, sv.user.email).deliver
  end
end
