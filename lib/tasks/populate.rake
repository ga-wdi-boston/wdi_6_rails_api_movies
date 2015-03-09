namespace :api do
  desc "Populate the Movie DB"

  task :populate => :environment do
    data_fname = "#{Rails.root}/data/small.list"
    #data_fname = "#{Rails.root}/data/business.list"

    movie = nil
    start_movie = true

    # TODO: Needs to be refactored to get all this code out of this
    # rake task. Create a class, or classes, in the lib directory to
    # movie refactored code into.
    Review.delete_all
    Movie.delete_all

    # File.open(, "r").each_line do |line|
    puts "Adding Movies from #{data_fname}"
    File.open(data_fname, "r").each_line do |line|
      begin
        if line.index('MV:') == 0
          if !start_movie
            movie.save!
            # Save the previous movie
            puts "Saved Movie: #{movie.to_json}"
          end
          start_movie = true
          title = line.split('MV: ').last.split('(').first.strip
          # create a new movie
          movie = Movie.new(title: title, total_gross: 0)
        elsif line.index('GR:') == 0
          # puts "line: #{line}"

          start_movie = false
          currency, gross, country = line.split('GR: ').last.split(" ")

          gross = Movie.conversion(currency, gross.gsub(',','_'))
          # puts "gross is #{gross}"

          # May need to do a currency conversion here, probably to US currency
          # movie.gross += gross.gsub(',', '_').to_i
          movie.total_gross += gross.to_i
        end
      rescue ArgumentError => e
        # Going to ignore this error:
        # invalid byte sequence in UTF-8
        # puts "Arg Error: #{e}"
      end
    end

  end
end
