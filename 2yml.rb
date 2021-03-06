#!/usr/bin/env ruby
require 'yaml'

def read_input
	STDIN.read.split("\n")	
end

arr = read_input.select do |line|
	line.include? '='
end

hash_arr = arr.map { |line| 
	parts = line.split '='
	{ key: parts[0], value: parts[1] }
}

yaml = Hash.new

hash_arr.each { |e| 
	yaml_keys = e[:key].split '.'

	def to_yamls(keys, value, yaml)
		y_key = keys.shift

		if keys.size == 0
			yaml[y_key] = value
			return
		end

		yaml[y_key]= Hash.new if yaml[y_key] == nil

		unless yaml[y_key].is_a? Hash
			temp_value = yaml[y_key]
			yaml[y_key] = { "text" => temp_value }
		end

		to_yamls keys, value, yaml[y_key]
	end

	to_yamls yaml_keys, e[:value], yaml
}

puts yaml.to_yaml
