require "sinatra"
require "pry"
require "csv"


set :bind, "0.0.0.0"
set :views, File.join(File.dirname(__FILE__), "views")


get "/" do
  redirect to("/movies")
end

get "/movies" do
  @movies = []
  CSV.foreach(csv_file, headers: true) do |row|
    @movies << row.to_h
  end
  erb :"movies/index"
end

post "/movies/new" do
  title = params["title"]
  release_year = params["release_year"]
  runtime = params["runtime"]
  if [title, release_year, runtime].include?("")
    @error = true
    erb :"movies/new"
  else
    CSV.open(csv_file, "a", headers: true) do |csv|
      csv << [params["title"], params["release_year"], params["runtime"]]
    end
    redirect "/movies"
  end
end


# Helper Methods

def csv_file
  if ENV["RACK_ENV"] == "test"
    "data/movies_test.csv"
  else
    "data/movies.csv"
  end
end

def reset_csv
  CSV.open(csv_file, "w", headers: true) do |csv|
    csv << ["title", "release_year", "runtime"]
  end
end
