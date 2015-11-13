# Review.delete_all
# Movie.delete_all

# TODO: Refactor to another place!!!
# Get all the tables, except the table for migrations
tables = ActiveRecord::Base.connection.tables - ['schema_migrations']

def remove_foreign_keys(tables)
  tables.each do |table|
    fks = ActiveRecord::Migration.foreign_keys("#{table}")
    unless fks.empty?
      fk_name = fks.first.options[:name]
      # puts "#{table} foreign key  is #{fk_name}"
      begin
        ActiveRecord::Migration.remove_foreign_key("#{table}".to_sym, name: fk_name.to_sym)
      rescue ArgumentError => ae
        puts "#{table} #{ae}"
      end
    end

  end
end

puts "Removing all foreign keys for each table"
# Dropping tables that have FK constraints will FAIL,
# if the order of dropping is wrong.
# So,let's remove all the FK constraints
remove_foreign_keys(tables)

tables.each do |table|
  puts "Deleting #{table}"
  # delete all data from the table
  ActiveRecord::Base.connection.execute "DELETE FROM #{table}"

  puts "Reseting primary key sequence for #{table}"
  # reset the primary key sequence for this table, start id column at 1
  ActiveRecord::Base.connection.reset_pk_sequence!("#{table}")
end

movie_titles = [ 'Alien', 'Birdman', 'Bird', 'Freeheld', 'Jaws', 'Star Wars', 'Butterfield 8', 'Being There', 'The Bicycle Thief', 'Klute', 'Lincoln', 'Affliction' ]
gross = [10_000, 100_000, 350_000, 90_340_000, 2_500_000]
movie_years = (1927..2015)

movie_titles.each do |title|
  # Faker::Lorem.words(rand(1..4)).join(' ')
  random_year = Random.new.rand(1927..2015) # custom range for years
  random_month =Random.new.rand(1..12)
  random_day  = Random.new.rand(1..30)
  movie_date = Date.new(random_year,random_month,random_day)

  desc = title == 'Jaws' ? 'shark attack' : Faker::Lorem.paragraph
  puts "Creating Movie #{title}"
  movie = Movie.create!(title: title, rating: Movie::RATINGS.sample, total_gross: gross.sample, description: desc, released_on: movie_date)

  1.upto(rand(0..3)) do
    movie.reviews.create!(name: Faker::Name.name, stars: rand(1..5), comment: Faker::Lorem.paragraph)
  end

end
