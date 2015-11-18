set :output, "#{path}/cron_log.log"

every :sunday, at: "3:30am" do
  runner "Card.update_prices"
end
