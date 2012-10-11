begin
  Rake::Task['environment'].invoke
rescue Exception => e
  if /Don't know how to build task/.match e.message
    task :environment
  end
end