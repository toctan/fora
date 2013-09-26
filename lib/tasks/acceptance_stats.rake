# To add acceptance tests to "rake stats" output
# Run `rake spec:statsetup`
# https://gist.github.com/sbleon/2360892

if Rake::Task.task_defined? 'spec:statsetup'
  Rake::Task['spec:statsetup'].enhance do
    require 'rails/code_statistics'
    ::STATS_DIRECTORIES << %w(Acceptance\ tests spec/acceptance) if File.exist?('spec/acceptance')
    ::CodeStatistics::TEST_TYPES << 'Acceptance tests' if File.exist?('spec/acceptance')
  end
end
