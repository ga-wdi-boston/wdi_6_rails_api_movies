Movie.delete_all

movie_names = [ 'Alien', 'Birdman', 'Bird', 'Freeheld', 'Jaws', 'Star Wars', 'Butterfield 8', 'Being There', 'The Bicycle Thief', 'Klute', 'Lincoln', 'Affliction' ]
gross = [10_000, 100_000, 350_000, 90_340_000, 2_500_000]
movie_years = (1927..2015)

1.upto(movie_names.size) do
  # Faker::Lorem.words(rand(1..4)).join(' ')
  title = movie_names.sample
  random_year = Random.new.rand(1927..2015) # custom range for years
  random_month =Random.new.rand(1..12)
  random_day  = Random.new.rand(1..30)
  movie_date = Date.new(random_year,random_month,random_day)

  puts "Creating Movie #{title}"
  Movie.create!(title: title, rating: Movie::RATINGS.sample, total_gross: gross.sample, description: Faker::Lorem.paragraphs(rand(1..3)), released_on: movie_date)
end
