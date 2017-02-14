require 'sinatra'
require 'pry'
require_relative './functions.rb'

wh = WallyHandler.new

get("/") do 
	erb :index
end

post("/check_click") do
	x = params["x"].to_i
	y = params["y"].to_i
	image_name = "ww-1.jpg"
	waldo_found = wh.check_click(image_name,x,y)
	binding.pry
	if waldo_found

	else

	end
end
