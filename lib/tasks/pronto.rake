# namespace :pronto do
task :pronto do
  Pronto.gem_names.each { |gem_name| require "pronto/#{gem_name}" }

  formatter = Pronto::Formatter::GithubFormatter.new
  Pronto.run('origin/master', '.', formatter)
end