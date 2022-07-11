# frozen_string_literal: true

desc 'list the webpage visits'
task :run, :input do |_, args|
  file_name = args[:input] || 'webserver.log'
  ruby "lib/parser.rb seed/#{file_name}"
end

desc 'test the webpage visits logic'
task :test do
  exec('rspec spec/*/*/*_spec.rb')
end
