# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
set :output, {:error => 'log/error.log', :standard => 'log/cron.log'}

every 10.minutes do
  rake "import_data:percept"
end

# Learn more: http://github.com/javan/whenever
