#
require_relative "Contact.rb"
require_relative "Database.rb"

class Runner
	INPUT_AREA = "_"*25 + "\b"*25
	LINE_OF_DASHES = "-"*25
	@@output_options = {
		#convert to sym with str.split.join('_').to_sym
		:base => ["add", "display all contacts", "display contact or modify it", "display attribute", "exit"],

		:display_contact_or_modify_it => ["Enter the contact's ID:"],
		:modify_contact => ["Modify attribute", "Delete", "Back to main list"],
		:modify_attribute => ["First name", "Last name", "Email", "Notes"],

		:display_attribute => ["ID", "First name", "Last name", "Email", "Notes"],

		:delete_contact => ["Enter the contact's ID"],
	}

	def display_contact(contact)
		puts LINE_OF_DASHES*2
		puts "\tID is:\t\t#{contact.id}"
		puts "\tFirst Name:\t#{contact.first_name}"
		puts "\tLast Name:\t#{contact.last_name}"
		puts "\tE-mail:\t\t#{contact.email}"
		puts "\tNote:\t\t#{contact.notes}"
		puts "\tID is:\t\t#{contact.id}"
		puts LINE_OF_DASHES*2
	end

	def display_contacts
		@DB.content.each do |contact|
			display_contact(contact)
		end
	end

	def add_contact
		info = Hash.new
		puts "What is the contact's first name?"
		print INPUT_AREA
		info[:first_name] = gets.chomp
		puts "What is the contact's last name?"
		print INPUT_AREA
		info[:last_name] = gets.chomp
		puts "What is the contact's email?"
		print INPUT_AREA
		info[:email] = gets.chomp
		puts "Any notes?"
		print INPUT_AREA
		info[:notes] = gets.chomp
		puts ""
		@DB.add(info)
	end

	def initialize
		@DB = Database.instance
		level = :base
		exit = false
		until exit
			i = 0
			@@output_options[level].each do |output|
				i+= 1
				puts i.to_s + ". #{output}"
			end
			input = gets.chomp.to_i
			level = @@output_options[:base][input.to_i-1].split.join('_').to_sym if level == :base
			if level == :add
			  add_contact
			  level = :base
			elsif level == :display_all_contacts
				display_contacts
				level = :base
			elsif level == :display_contact_or_modify_it
				puts @@output_options[level][0]
				id = gets.chomp.to_i
				display_contact(@DB.content_by_id(id))
				puts "\n-----------------------"
				i = 0
				@@output_options[:modify_contact].each do |output|
					i+= 1
					puts i.to_s + ". #{output}"
				end
				input = gets.chomp.to_i
				if input == 1
					i = 0
					puts "Which attribute do you wish to modify?"
					@@output_options[:modify_attribute].each do |output|
						i+= 1
						puts i.to_s + ". #{output}"
					end
					key = gets.chomp.to_i
					attribute = @@output_options[:modify_attribute][key-1]
					puts "Modify #{attribute} with what value?"
					print INPUT_AREA
					value = gets.chomp
					@DB.modify_contact(id, attribute.downcase.split.join('_').to_sym, value)
					level = :base
				elsif input == 2
					@DB.delete(id)
					level = :base
				elsif input == 3
					level = :base
				end
			elsif level == :display_attribute
				puts "Enter a name or email"
				print INPUT_AREA
				input = gets.chomp
				@DB.find_by_attribute(input).each do |contact|
					display_contact(contact)
				end
				puts "\nNo more scores\n"
				level = :base
			elsif level == :exit
				exit = true
			end
		end
	end

	private

	def valid_input
		str = gets.chomp
	end
end

Runner.new 


#lessons:
#use each_with_index to loop thoguh array and count the index
#use grep to search an array for matching pattern input a.grep("a") returns array of all objects with a
#use case when instead of if/then for specific cases
#can use Contact = Struct.new(:id, name, etc) instead of entire class, since contacts was just a bundle of attributes
#design your code better ahead of time
#can use send method on object to send a method name as a variable
# ex: k.name = "hi", k.email = "yo"
#option = [:name, :yo].shuffle.first
# k.send(option, "whats up") => either k.name or k.email = "whats up"