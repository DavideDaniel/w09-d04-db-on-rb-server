require 'sinatra'
require 'pry'
require 'sqlite3'
require 'pry'
db = SQLite3::Database.new "petulance.db"

get "/favicon.ico" do
end

get '/pets' do
	pets = db.execute("SELECT * FROM pets")
	erb :index, locals: {pets: pets}
end

get '/pet/:id' do
	thispet = db.execute("SELECT * FROM pets WHERE ID = (?)", params[:id].to_i)
	erb :shows, locals: {thispet: thispet}
end

put '/pet/:id' do
	db.execute("UPDATE pets SET name = (?) WHERE ID = (?)", params["newname"], params[:id].to_i)
	redirect '/pets'
end

post '/pet' do
	newpet = [params["name"], params["type"]]
	db.execute("INSERT INTO pets (name, type) VALUES(?, ?)", newpet)
	redirect '/pets'
end

delete '/pet/:id' do
	db.execute("DELETE from pets WHERE ID = (?)", params[:id].to_i)
	redirect '/pets'
end