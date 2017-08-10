puts 'Cleaning the database...'

Author.delete_all

puts 'Creating authors...'

Author.create(name: 'Jan Brzechwa')
Author.create(name: 'Bertolt Brecht')
