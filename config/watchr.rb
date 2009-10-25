def run_spec_file(test_file)
  puts "\n\n"
  system "date"
  puts test_file

  system %Q{./script/spec '#{test_file}' --diff unified --format nested --color}
end

watch('app/models/(.*)\.rb') do |md|
  test_file = "spec/models/#{md[1]}_spec.rb"

  run_spec_file test_file
end

watch('app/controllers/(.*)\.rb') do |md|
  test_file = "spec/controllers/#{md[1]}_spec.rb"

  run_spec_file test_file
end

watch('app/views/(.*)') do |md|
  test_file = "spec/views/#{md[1]}_spec.rb"

  if File.exists?(test_file)
    run_spec_file test_file
  end
end

watch('spec/.*_spec\.rb') do |md|
  test_file = "#{md[0]}"

  run_spec_file test_file
end
