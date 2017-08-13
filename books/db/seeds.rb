puts 'Cleaning the database...'

Author.delete_all
Book.delete_all

puts 'Creating authors...'

brzechwa = Author.create(name: 'Jan Brzechwa', born: '1898-08-15', died: '1966-07-02')
brecht = Author.create(name: 'Bertolt Brecht', born: '1898-02-10', died: '1956-08-14')

Book.create(title: 'Kaczka Dziwaczka', author: brzechwa)
Book.create(title: 'Akademia Pana Kleksa', author: brzechwa)
Book.create(title: 'Ptasie plotki', author: brzechwa)
Book.create(title: 'Dreigroschenroman', author: brecht)