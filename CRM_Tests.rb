require "test/unit"
require_relative "Contact.rb"
require_relative "Database.rb"
#require_relative "Runner.rb"

class TestDatabase < Test::Unit::TestCase
	def params
		Hash[:id, 1, :first_name, "Stu", :last_name, "G", :email, "sg", :notes, "yo"]
	end

	def setup
		@db = Database.instance
		@contact = @db.add(params)
	end

	def test_users_array_is_array
		assert @db.contacts.is_a?(Array)
	end

	def test_adding_contact_adds_to_contacts
		assert @db.contacts.include?(@contact)
	end

	def test_adding_contact_has_params
		assert @contact.id.is_a?(Fixnum)
		assert_equal @contact.first_name, "Stu"
		assert_equal @contact.last_name, "G"
		assert_equal @contact.email, "sg"
		assert_equal @contact.notes, "yo"
	end

	def test_modify_contact_changes_attribute
		@db.modify_contact(@contact.id, :first_name, "Mark")
		assert_equal @contact.first_name, "Mark"
	end

	def test_delete_contact_removes_contact_from_users_array
		@db.delete(@contact.id)
		assert !@db.contacts.include?(@contact)
	end

	def test_find_by_attribute_returns__array_of_contacts_with_attribute
		result = @db.find_by_attribute("Stu")
		assert result.is_a?(Array)
		assert result.include?(@contact)
	end
end

class TestContacts < Test::Unit::TestCase
	def params
		Hash[:id, 1, :first_name, "Stu", :last_name, "G", :email, "sg", :notes, "yo"]
	end

	def setup
		@contact = Contact.new(params)
	end

	def test_contact_is_not_nil
		refute @contact.nil?
	end

	def test_contact_has_first_name
		assert_equal @contact.first_name, "Stu"
	end

	def test_contact_has_last_name
		assert_equal @contact.last_name, "G"
	end

	#etc, these are just example tests, written after the run code was already written
end