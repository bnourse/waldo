require 'sinatra'
require 'pry'
require_relative './functions.rb'

wh = WaldoHandler.new
waldo_found = false
new_high_score = false

get("/") do 
	erb :index
end

post("/check_click") do
	x = params["x"].to_i
	y = params["y"].to_i
	image_name = "ww-1.jpg"
	waldo_found = wh.check_click(image_name,x,y)
	# binding.pry
	redirect("/check_click")
end

get("/check_click") do
	@waldo_found = waldo_found
	erb :check_click
end

post("/check_high_score") do
	new_high_score = false
	image_name = params["image_name"]
	seconds_taken = params["seconds_taken"].to_i
	new_high_score = wh.check_high_score(image_name,seconds_taken)
	# binding.pry
	redirect("/check_high_score")
end

get("/check_high_score") do
	@new_high_score = new_high_score
	erb :check_high_score
end

