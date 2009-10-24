watch('app/models/(.*)\.rb') do |md|
  test_file = "spec/models/#{md[1]}_spec.rb"

  puts "\n\n"
  system "date"
  puts test_file

  system %Q{./script/spec '#{test_file}' --diff unified --format nested --color}
end

watch('app/controllers/(.*)\.rb') do |md|
  test_file = "spec/controllers/#{md[1]}_spec.rb"

  puts "\n\n"
  system "date"
  puts test_file

  system %Q{./script/spec '#{test_file}' --diff unified --format nested --color}
end

watch('spec/.*_spec\.rb') do |md|
  test_file = "#{md[0]}"

  puts "\n\n"
  system "date"
  puts test_file

  system %Q{./script/spec '#{test_file}' --diff unified --format nested --color}
end

watch('test/.*_test\.rb') do |md|
  test_file = "#{md[0]}"

  puts "\n\n"
  system "date"
  puts test_file

  system %Q{ruby1.8 -rubygems -e "require 'redgreen'" -I.:lib:test -e "require '#{test_file}'"}
end
