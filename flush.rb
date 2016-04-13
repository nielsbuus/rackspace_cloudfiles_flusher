require 'fog'
require_relative 'config'

rackspace_credentials = Config.fetch(:credentials)
name_of_bucket_to_delete = Config.fetch(:bucket_to_flush)

worker_count = 50

work_queue = Queue.new

fog = Fog::Storage.new(rackspace_credentials)

bucket_files = fog.directories.find { |dir| dir.key == name_of_bucket_to_delete }.files

puts "Welcome to rackspace_cloudfiles_flusher - getting ready to flush #{name_of_bucket_to_delete} with #{worker_count} workers!"
puts "Setting up queue with all those damn files..."

bucket_files.each do |file|
  if work_queue.length % 25_000 == 0
    puts "Queue contains: #{work_queue.length}"
  end
  work_queue.push(file)
end

total_size = work_queue.length

puts "Preparation completed - we are ready to delete #{work_queue.length} objects from #{name_of_bucket_to_delete}!"

sleep 1

starting_time = Time.now

Thread.new do
  while work_queue.length > 0
    deletions = total_size - work_queue.length
    progress = deletions.to_f / total_size
    spent_time = Time.now - starting_time
    remaining_time = (spent_time / progress) - spent_time

    remaining_time_in_minutes = (remaining_time / 60).round

    puts "Deleted #{deletions} out of #{total_size}. We are #{(100 * progress).round(1)} % done - estimated time left: #{remaining_time_in_minutes} minutes."
    sleep 15
  end
end

worker_count.times.map do
  Thread.new do
    file = nil
    begin
      while file = work_queue.pop
        file.destroy
        # puts "Deleted #{file.key}"
      end
    rescue RuntimeError => e
      work_queue.push(file)
      puts "Could not delete: #{file.key} due to: #{e}"
    end
  end
end.each(&:join)



puts "Completed in #{(Time.now - starting_time).round / 60} minutes."
