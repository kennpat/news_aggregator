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
		binding.pry
	end
	news_arr
end

def save_news(filename, article_title, article_link, article_summary)
	time  = Time.new
	CSV.open( filename, 'a' ) do |csv|
		csv.instert(0, [article_title, time, article_link, article_summary])
	end
end

#gets

get '/' do
	@news = read_news('news.csv')
	#binding.pry
	erb :index
end

get '/new' do

	erb :new
end

#puts