%w[
  issue_updater
].each do |file|
  require File.expand_path("../#{file}", __FILE__)
end
