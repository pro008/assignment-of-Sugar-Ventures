class ProfittabilityPlotsSale

  def initialize
    get_input
  end

  def get_input
    puts "Please Enter your Plots sale (> 0 && < 2,000,000):"
    number = gets.chomp
    puts "Please Enter your range sale (-1000 <-> 1000):"
    range = gets.chomp
    get_key_combinations(number, range)
  end

  def validate_number(number, range_profit)
    unless (number.match(/^[0-9]*$/) && number.to_i > 0 && number.to_i <= 2_000_000) && range_profit.length == number.to_i
      puts "number of plots for sale must from 1 to 2,000,000, and range length has equal to plots size"
      return false
    end

    range_profit.each do |range|
	    unless (range.match(/^-?[0-9]\d*(\.\d+)?$/) && range.to_i >= -1000 && range.to_i <= 1000)
	      puts "range of plots for sale must from -1000 to 1000"
	      return false
	    end
	  end

    puts "---------------------------------------------------"
    return true
  end

# ------------------------------------------------------------

	def profit_type number
		return "Neuture" if number == "0"
		return "Loss" if number.include? "-"

		"Profit"
	end

	def filter_by_type(arr, f_index)
		f_plot = arr.shift
		f_plot_value = f_plot.to_i
		f_plot_type = profit_type f_plot
		is_f_loss = (f_plot_type == "Loss")
		
		current_index = f_index

		while arr.length != 0
			current_type = profit_type arr[0]

			if current_type == f_plot_type
				f_plot_value += arr[0].to_i
			else
				return [[f_index, current_index], current_index + 1, f_plot_value] if !is_f_loss || current_type != "Neuture"
			end

			current_index += 1
			arr.shift
		end

		return [[f_index, current_index], current_index, f_plot_value]
	end
	
	def cluster_profit(arr_profit)
		return [] if arr_profit.empty?

		current_index = 0
		result =[]

		while arr_profit.length != 0
			arr_profit.shfit if arr_profit == "0"
	  	i_range, current_index, f_value = filter_by_type(arr_profit, current_index)
	  	result << {range: i_range, value: f_value}
	  end

    result
	end

	def merge_continious_prof_type(arr)
		arr.shift while arr.first[:value] <= 0 # begin with Profit
		arr.pop while arr.last[:value] <= 0 # end with Profit

		result, index =[arr.first], 1

		while index != arr.length
			if arr[index][:value] < 0
				result << arr[index]
			else
				if result.last[:value] >= 0
					result.last[:value] += arr[index][:value]
				else
					result << arr[index]
				end
			end

			index += 1
		end

		result
	end

	def group_prof_right_sum(arr)
		results = [arr.shift]

		arr.each_slice(2) do |loss, profit|
			results << loss and break if profit.nil?
			if profit[:value] >= loss[:value].abs && results.last[:value] > 0
				if results.length == 1 && loss[:value].abs > results.last[:value]
					results  = [profit]
				else
					results.last[:value] += loss[:value] + profit[:value]
					results.last[:range][1] = profit[:range][1]
				end
			else
				results << loss and results << profit
			end					
		end

		results
	end

	def find_the_largest_prof(arr)
		start_index, end_index, max_sub = arr.first[:range][0], arr.first[:range][1], arr.first[:value]
		(0...arr.length).each do |n|
		  (n...arr.length).each do |i|
		  	sum_arr = arr[n..i].map{|e| e[:value]}.inject(:+)
		   	if max_sub < arr[n..i].map{|e| e[:value]}.inject(:+)
		   		max_sub = sum_arr
		    	start_index, end_index = arr[n][:range][0], arr[i][:range][1]
		    end
		  end
		  max_sub
		end

		[start_index + 1, end_index + 1, max_sub]
	end


	def get_key_combinations(number, range)
    arr_profit = range.split(" ")
    get_input unless validate_number(number, arr_profit)

   	g_profit = cluster_profit(arr_profit)
   	g_profit_by_type = merge_continious_prof_type(g_profit)
   	skim_filter_profit = group_prof_right_sum g_profit_by_type
   	results = find_the_largest_prof(skim_filter_profit)

   	puts("#{results[0]} #{results[1]} #{results[2]}")
  end

end

ProfittabilityPlotsSale.new