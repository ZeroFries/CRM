#
	attr_accessor :id, :first_name, :last_name, :email, :notes

	def initialize (params)
    @id = params[:id] #id is given by database as it counts number of contact entries
    @first_name = params[:first_name] #the rest of params are given by user input in Runner
    @last_name = params[:last_name]
    @email = params[:email]
    @notes = params[:notes]
	end
end