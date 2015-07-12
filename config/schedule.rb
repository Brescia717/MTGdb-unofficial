set :output, "#{path}/log/cron.log"

every :sunday, at: "3:30 AM" do
  runner "Card.update_prices"
end
