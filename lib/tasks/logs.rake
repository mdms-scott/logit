namespace :logs do
  desc "Read the log files in the import_logs directory"
  task :parse => :environment do
    LogParser.parse_logs
  end
end
