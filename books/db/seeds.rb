puts 'Cleaning the database...'

Author.delete_all

puts 'Creating authors...'

Author.create(name: 'Jan Brzechwa', born: '1898-08-15', died: '1966-07-02')
Author.create(name: 'Bertolt Brecht', born: '1898-02-10', died: '1956-08-14')
