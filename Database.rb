#
require 'singleton'
require_relative 'Contact.rb'
class Database
	include Singleton

	def initialize
		@users_array = []
	end

	def add(info_hash)
		contact = Contact.new({
			id: contacts.size,
			first_name: info_hash[:first_name],
			last_name: info_hash[:last_name],
			email: info_hash[:email],
			notes: info_hash[:notes]
			})
			contacts << contact
			contact
	end

	def find_by_attribute(input)
		result = []
		pattern = /#{input}/
		contacts.each { |contact|
			result << contact if contact.first_name =~ pattern || contact.last_name =~ pattern || contact.email =~ pattern 
		}
		result
	end

	def contacts
		@users_array
	end

	def delete(ids)
		contacts.delete_at ids
		contacts.each_with_index { |contact,i|
			contact.id = i
		}
	end
	def content
		contacts
	end

	def content_by_id(id)
		contacts[id]
	end

	def modify_contact(id,key,value)
		user=contacts[id]
		case key
			when :first_name then user.first_name = value
			when :last_name then user.last_name = value
			when :email	then user.email = value
			when :notes then user.notes = value
		end
	end



end
