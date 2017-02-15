require 'csv'

class WaldoHandler

	def initialize
		@cll = CSVLocationLoader.new
		@close_enough = 25
	end

	def check_click(image_name,x,y)
		loc_hash = @cll.get_location_for_image_name(image_name)
		correct_x = loc_hash["waldo_x"].to_i
		correct_y = loc_hash["waldo_y"].to_i
		return click_is_close_enough(x,y,correct_x,correct_y)
	end

	def click_is_close_enough(x,y,correct_x,correct_y)
		x_min_acceptable = correct_x - @close_enough
		x_max_acceptable = correct_x + @close_enough
		y_min_acceptable = correct_y - @close_enough
		y_max_acceptable = correct_y + @close_enough

		x_is_acceptable = x >= x_min_acceptable && x <= x_max_acceptable
		y_is_acceptable = y >= y_min_acceptable && y <= y_max_acceptable

		click_is_acceptable =  x_is_acceptable && y_is_acceptable
		return click_is_acceptable
	end
end

class CSVLocationLoader
	def initialize
		@csv_filename = "waldo.csv"
	end

	def set_csv_filename(filename)
		@csv_filename = filename
	end

	def get_location_for_image_name(image_name)
		location_hash = load_location_hash
		return location_hash[image_name]
	end

	def load_location_hash
		location_hash = {}
			CSV.foreach(@csv_filename, {headers: true, return_headers: false}) do |row|
				image_name = row["image_name"];
				location_hash[image_name] = row.to_hash
			end
		return location_hash
	end
end
