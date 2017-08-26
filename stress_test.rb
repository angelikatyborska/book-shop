require 'net/http'

read = ->(sleep_time) do
  i = 0
  Thread.new do
    loop do
      puts "#{sleep_time}: #{i += 1}"
      Net::HTTP.get(URI('http://localhost:3000/books'))
      sleep sleep_time
    end
  end
end

read.(0.01)
# read.(0.1)
# read.(0.3)
# read.(0.7)
# read.(1.1)
sleep