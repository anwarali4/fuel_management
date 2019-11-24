class Airport

	attr_accessor :id, :name, :capacity, :availability, :transactions

	def initialize(options)
		@id = options[:id]
		@name = options[:name]
		@capacity = options[:capacity]
		@availability = options[:availability ]
		@transactions = []
	end

	def self.all
		puts "=========================================="
		puts "Airport \t\t\t\t\t\t\t\t Fuel Available"
    ObjectSpace.each_object(self).to_a.each do |obj|
    	puts "#{obj.name} \t\t\t\t#{obj.availability}"
    end
  end

  def self.find_airport id
  	ObjectSpace.each_object(self).to_a.each do |obj|
  		if(obj.id == id)
    	 	return  obj
    	 end
    end
    return nil
  end

  def check_limit fuel
  	if fuel <=  self.capacity - self.availability
  		return true
  	end
  end

  def check_availabilty fuel
  	if fuel <= self.availability
  		return true
  	end
  end

  def self.reintiliaze
  	ObjectSpace.each_object(self).to_a.each do |obj|
    	if obj.id == 1
    		obj.name = "Indira Gandhi International Airport,Delhi"
    		obj.capacity = 500000
    		obj.availability = 25066
    		obj.transactions = []
    	elsif obj.id == 2
    		obj.name = 'Rajiv Gandhi International Airport,Hyderabad'
    		obj.capacity = 500000
    		obj.availability = 350732
    		obj.transactions = []
    	elsif obj.id == 3
    		obj.name = 'Chhatrapati Shivaji InternationalAirport, Mumbai'
    		obj.capacity = 500000
    		obj.availability = 288467
    		obj.transactions = []
    		obj.
    	elsif obj.id == 4
    		obj.name = 'Chennai International Airport, Chennai'
    		obj.capacity = 500000
    		obj.availability = 497460
    		obj.transactions = []
    	elsif obj.id == 5
    		obj.name =  'Kempegowda International Airport,Bangalore'
    		obj.capacity = 500000
    		obj.availability = 123456
    		obj.transactions = []
  		end
    end
  end

  def self.transaction
    ObjectSpace.each_object(self).to_a.each do |obj|
    	if (obj.transactions.any?)
	      puts "Airport: #{obj.name}"
	      puts "Date/time \t\t Type \t Fuel \t Aircraft"
	      obj.transactions.each do |transaction|
	        puts "#{transaction[:Datetime]} \t #{transaction[:Type]} \t #{transaction[:Fuel]} \t #{transaction[:Aircraft]}"
	      end
	      puts "Fuel Available: #{obj.availability}"
	      puts "-----------------------------------"
	    end
    end
  end

end

class FuelManagement
	options1 = {id: 1, name: 'Indira Gandhi International Airport,Delhi', capacity: 500000, availability: 25066}
	options2 = {id: 2, name: 'Rajiv Gandhi International Airport,Hyderabad', capacity: 500000, availability: 350732}
	options3 = {id: 3, name: 'Chhatrapati Shivaji InternationalAirport, Mumbai', capacity: 500000, availability: 288467}
	options4 = {id: 4, name: 'Chennai International Airport, Chennai', capacity: 500000, availability: 497460}
	options5 = {id: 5, name: 'Kempegowda International Airport,Bangalore', capacity: 500000, availability: 123456}
	@@airport1 = Airport.new(options1)
	@@airport2 = Airport.new(options2)
	@@airport3 = Airport.new(options3)
	@@airport4 = Airport.new(options4)
	@@airport5 = Airport.new(options5)  

	def self.menu
		puts '==========Fuel Management======================'
		puts '0. Initiate / re-initiate the airport fuel data based on the table below. '
		puts '1. Show Fuel Summary at all Airports '
		puts '2. Update Fuel Inventory of a selected Airport '
		puts '3. Fill Aircraft '
		puts '4. Show Fuel Transaction for All Airport '
		puts '9.  Exit '
		puts '====================================='
		puts 'Choose Your Option'
		option  = gets.chomp.to_i

		
		if option == 0
			#Initiate / re-initiate the airport fuel
			Airport.reintiliaze
			FuelManagement.continue
		elsif option == 1
			#Show Fuel Summary at all Airports
			Airport.all
			FuelManagement.continue
		elsif option == 2
			#Update Fuel Inventory of a selected Airport
			FuelManagement.update
			FuelManagement.continue
		elsif option == 3
			#Fill Aircraft
			fill_fuel_in_aircraft
			FuelManagement.continue
		elsif option == 4
			#Show Fuel Transaction for All Airport
			Airport.transaction
			FuelManagement.continue
		elsif option == 9
			exit(true)
		else
			puts 'invalid option'
			puts 'Choose Your Option'
			option  = gets.chomp.to_i
		end
	end

	#Option Code | Title: 2 | Update Fuel Inventory of a selected Airport
	def self.update
		puts 'Enter Airport ID: '
		airport_id  = gets.chomp.to_i
		obj = Airport.find_airport airport_id
		unless obj.nil?
			puts 'Enter Fuel (ltrs): '
			fuel  = gets.chomp.to_i
			if obj.check_limit fuel
				obj.availability = obj.availability + fuel
				obj.transactions << {Datetime: Time.now.strftime("%y-%m-%d %H:%M:%S"), Type: 'In', Fuel: fuel, Aircraft: ''}
				puts 'Success: Fuel inventory updated'
			else
				puts 'Error: Goes beyond fuel capacity of the airport'
			end
		else
			puts "Airport couldn't find"
		end
	end

	#Option Code | Title: 3 | Fill Aircraft
	def self.fill_fuel_in_aircraft
		puts 'Enter Airport ID: '
		airport_id  = gets.chomp.to_i
		obj = Airport.find_airport airport_id
		unless obj.nil?
			puts 'Enter Aircraft Code: '
			code  = gets.chomp
			puts 'Enter Fuel (ltrs): '
			fuel  = gets.chomp.to_i
			if obj.check_availabilty fuel
				obj.availability = obj.availability - fuel
				obj.transactions << {Datetime: Time.now.strftime("%y-%m-%d %H:%M:%S"), Type: 'Out', Fuel: fuel, Aircraft: code}
				puts 'Success: Request for the has been fulfilled'
			else
				puts 'Failure: Request for the fuel is beyond availability at airport'
			end
		else
			puts "Airport couldn't find"
		end
	end

	def self.continue
		puts 'Do you want to continue? [Y/n] Abort.'
		choice  = gets.chomp
		if choice.casecmp('Y') == 0
			menu
		elsif choice.casecmp('N') == 0
			exit(true)
		else
			continue
		end	
	end

	FuelManagement.menu
end
