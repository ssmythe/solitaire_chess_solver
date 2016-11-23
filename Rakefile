begin
  require 'cucumber'
  require 'cucumber/rake/task'
  require 'rdoc/task'
  require 'rubycritic'

  # features
  Cucumber::Rake::Task.new(:features) do |t|
    # t.cucumber_opts = 'features --format pretty'
    t.cucumber_opts = 'features --format html --out tmp/cucumber.html'
  end

  task :rubocop do
    sh 'rubocop --format html -o tmp/rubocop.html || true'
  end

  # task :metric_fu do
  #   sh 'metric_fu --no-flog --no-open'
  #   # sh 'metric_fu --no-open'
  # end

  task :rubycritic do
    sh 'rubycritic'
  end

  # all tests
  task test: [:features, :rubocop, :rubycritic]

  desc 'generate API documentation to doc/rdocs/index.html'
  task :rdoc do
    sh 'rdoc -all --op tmp/doc --exclude tmp'
  end

  task default: [:rdoc, :test]
end
