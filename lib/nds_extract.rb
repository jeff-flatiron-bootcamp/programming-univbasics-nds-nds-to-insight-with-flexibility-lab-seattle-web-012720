# Provided, don't edit
require 'directors_database'
require 'pp'

# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2],
# [3,4,5], [6]] => [1,2,3,4,5,6].

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end


# Your code after this point

def movies_with_director_key(name, movies_collection)
  # GOAL: For each Hash in an Array (movies_collection), provide a collection
  # of movies and a directors name to the movie_with_director_name method
  # and accumulate the returned Array of movies into a new Array that's
  # returned by this method.
  #
  # INPUT:
  # * name: A director's name
  # * movies_collection: An Array of Hashes where each Hash represents a movie
  #
  # RETURN:
  #
  # Array of Hashes where each Hash represents a movie; however, they should all have a
  # :director_name key. This addition can be done by using the provided
  # movie_with_director_name method
  
  puts "Calling movies_with_director_key #{name} #{movies_collection}"
  
  row_index = 0
  collection_Directors_Movies = []
  while (movies_collection[row_index]) do
    collection_Directors_Movies << movie_with_director_name(name, movies_collection[row_index])
    row_index+=1
  end
  collection_Directors_Movies
end


def gross_per_studio(collection)
  # GOAL: Given an Array of Hashes where each Hash represents a movie,
  # return a Hash that includes the total worldwide_gross of all the movies from
  # each studio.
  #
  # INPUT:
  # * collection: Array of Hashes where each Hash where each Hash represents a movie
  #
  # RETURN:
  #
  # Hash whose keys are the studio names and whose values are the sum
  # total of all the worldwide_gross numbers for every movie in the input Hash
  
  pp collection
  
  process_collection = []
  return_hash = {}
  movie_index = 0
  
  #convert modifed input from Db to acceptable AoH design
  if(collection[0][:director_name])
    
    director_index = 0
    while(collection[director_index][:director_name]) do

      title = collection[director_index][:title][:title]
      studio = collection[director_index][:title][:studio]
      worldwide_gross = collection[director_index][:title][:worldwide_gross]
      
      puts "Converting an item: #{collection[director_index]}"
      puts "\t Subitem title Hash: #{collection[director_index][:title]}"
      puts "\t Subitem title string: #{title}"
      puts "\t Subitem title studio: #{studio}"
      puts "\t Subitem title worldwide_gross: #{worldwide_gross}"
      temp_hash = {:title => title, :studio => studio, :worldwide_gross =>worldwide_gross}
      puts "\t Prepped hash: #{temp_hash}"
      process_collection.push(temp_hash)
      director_index+=1
    end
    collection = process_collection
  end
    
  movie_index = 0
  while(collection[movie_index]) do
    #pp collection[movie_index]
    puts "Attempting to add #{collection[movie_index]}"
    if(return_hash[collection[movie_index][:studio]])
      puts "Found Item and adding #{collection[movie_index][:worldwide_gross]}"
      return_hash[collection[movie_index][:studio]] = return_hash[collection[movie_index][:studio]] + collection[movie_index][:worldwide_gross]
    else
      puts "Adding item studio named: #{collection[movie_index][:studio]} with value #{collection[movie_index][:worldwide_gross]}"
      return_hash[collection[movie_index][:studio]] = collection[movie_index][:worldwide_gross]
    end
  
    movie_index+=1
  end
  puts "BEGIN RETURN_HASH OUTPUT"
  pp return_hash
  puts "END RETURN_HASH OUTPUT"
  return_hash
end

def movies_with_directors_set(source)
  # GOAL: For each director, find their :movies Array and stick it in a new Array
  #
  # INPUT:
  # * source: An Array of Hashes containing director information including
  # :name and :movies
  #
  # RETURN:
  #
  # Array of Arrays containing all of a director's movies. Each movie will need
  # to have a :director_name key added to it.
  pp "Calling movies_with_directors_set #{source}"
  
  row_index = 0
  collection_Movies_With_Directors = []
  while (source[row_index]) do
    movie_index = 0
    while (source[row_index][:movies][movie_index]) do
      collection_Movies_With_Directors << [{director_name: source[row_index][:name], title: source[row_index][:movies][movie_index]}]
      movie_index+=1
    end
    row_index+=1
  end
  collection_Movies_With_Directors
end

# ----------------    End of Your Code Region --------------------
# Don't edit the following code! Make the methods above work with this method
# call code. You'll have to "see-saw" to get this to work!

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
