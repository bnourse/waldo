require 'sinatra'
require 'pry'
require_relative './functions.rb'

wh = WaldoHandler.new
waldo_found = false

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
