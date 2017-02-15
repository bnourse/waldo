require 'csv'

class WaldoHandler

	def initialize
		@wcm = WaldoCSVManipulator.new
		@close_enough = 25
	end

	def set_close_enough(pixel_difference)
		@close_enough = pixel_difference
	end

	def check_click(image_name,x,y)
		loc_hash = @wcm.get_hash_for_image_name(image_name)
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

	def check_high_score(image_name,seconds_taken)
		is_new_high_score = false
		cur_hash = @wcm.get_hash_for_image_name(image_name)
		current_high_score = cur_hash["high_score"].to_i
		if seconds_taken < current_high_score 
			is_new_high_score = true
			@wcm.set_high_score_for_image_name(image_name,seconds_taken)
		end
		return is_new_high_score
	end
end


class WaldoCSVManipulator
	def initialize
		@csv_filename = "waldo.csv"
	end

	def set_csv_filename(filename)
		@csv_filename = filename
	end

	def get_hash_for_image_name(image_name)
		whole_hash = load_hash
		return whole_hash[image_name]
	end

	def load_hash
		whole_hash = {}
		CSV.foreach(@csv_filename, {headers: true, return_headers: false}) do |row|
			image_name = row["image_name"];
			whole_hash[image_name] = row.to_hash
		end
		return whole_hash
	end

	def set_high_score_for_image_name(image_name,new_high_score)
		cur_hash = load_hash
		cur_hash[image_name]["high_score"] = new_high_score
		open(@csv_filename, 'w') do |f|
			f.puts "image_name,waldo_x,waldo_y,high_score"		
			cur_hash.each do |k,v|
				f.puts csv_line_for(v)
			end
		end
	end

	def csv_line_for(image_name_hash)
		return image_name_hash["image_name"] + "," + image_name_hash["waldo_x"].to_s + "," + image_name_hash["waldo_y"].to_s + "," + image_name_hash["high_score"].to_s
	end
end
