watch('app/models/(.*)\.rb') do |md|
  test_file = "test/unit/#{md[1]}_test.rb"

  puts "\n\n"
  system "date"
  puts test_file

  system %Q{ruby1.8 -rubygems -e "require 'redgreen'" -I.:lib:test -e "require '#{test_file}'"}
end

watch('app/controllers/(.*)\.rb') do |md|
  test_file = "test/functional/#{md[1]}_test.rb"

  puts "\n\n"
  system "date"
  puts test_file

  system %Q{ruby1.8 -rubygems -e "require 'redgreen'" -I.:lib:test -e "require '#{test_file}'"}
end

watch('test/.*_test\.rb') do |md|
  test_file = "#{md[0]}"

  puts "\n\n"
  system "date"
  puts test_file

  system %Q{ruby1.8 -rubygems -e "require 'redgreen'" -I.:lib:test -e "require '#{test_file}'"}
end
