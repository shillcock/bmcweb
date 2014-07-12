namespace :security do
  task :brakeman do
    sh "brakeman -q -z --report-direct"
  end

  task :rails_best_practices do
    path = File.expand_path("../../../", __FILE__)
    sh "rails_best_practices #{path}"
  end
end

task :security => ['security:brakeman', 'security:rails_best_practices']
