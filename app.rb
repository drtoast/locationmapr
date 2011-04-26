require 'rubygems'
require 'sinatra'
require 'haml'
require 'sqlite3'
require 'json'

get '/' do
  haml :map
end

get '/markers' do
  content_type :json
  from = time_to_iphone(params[:from])
  to = time_to_iphone(params[:to])
  markers = []
  SQLite3::Database.new("consolidated.db") do |db|
    db.execute("select * from CellLocation where Timestamp >= ? and Timestamp <= ?", from, to) do |row|
      markers << {:lat => row[5], :lng => row[6], :time => iphone_to_time(row[4]), :conf => row[12], :ha => row[7]}
    end
  end
  {:markers => markers}.to_json
end

def time_to_iphone(t)
  arr = t.split(/\//)
  t2 = Time.new(arr[2], arr[0], arr[1])
  (t2 - Time.new(2001,1,1)).to_i
end

def iphone_to_time(t)
  Time.new(2001, 1, 1) + t
end