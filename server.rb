# Patrick Kennedy
# News Aggregator Challenge
# 11/19/14

require 'pry'
require 'sinatra'
require 'sinatra/contrib'
require 'csv'

def read_news(filename)
	news_arr = []

	CSV.foreach(filename, headers: true) do |row|
		news_arr << {article_title: row['article_title'],
			submission_date: row['submission_date'],
			article_link: row['article_link'],
			article_summary: row['article_summary']
		}
		#  binding.pry
	end
	news_arr
end

def save_news(filename, article_title, article_link, article_summary)
	time  = Time.new
	CSV.open( filename, 'a' ) do |csv|
		csv << [article_title, time, article_link, article_summary]
	end
end

# gets

# for the base address
get '/' do
	@news = read_news('news.csv')
	# binding.pry
	erb :index
end

# for the /article address requirement
get '/article' do
	@news = read_news('news.csv')
	#binding.pry
	erb :index
end

get '/article/new' do
	erb :new
end

#posts

post '/article/new' do
	# hash structure - refer to above function to read the csv file

	@title = params[:article][:name]
	@link = params[:article][:link]
	@summary = params[:article][:summary]
	#binding.pry
	save_news('news.csv', @title, @link, @summary)
	# if !params[:article_title].empty? && params[:article_link].empty? && params[:article_summary].empty?
	# 	#add the article
	# 	save_news('news.csv', @title, @link, @summary)

	# 	redirect '/'
	# else
	# 	@error_message = []
	# 	@error_message << "You must enter a title." if params[:article_title].empty?
	# 	@error_message << "You must enter a link." if params[:article_link].empty?
	# 	@error_message << "You forgot to add a summary to the story" if params[:article_summary].empty?
	@news = read_news('news.csv')
	erb :index
	# end
	
end

