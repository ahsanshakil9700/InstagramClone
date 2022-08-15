namespace :story do

  desc "Delete all stories older than 24 hours"
  task delete_stories_older_than_24_hours: :environment do
    Story.where(['created_at < ?', 1.minute.ago]).destroy_all
  end
end
