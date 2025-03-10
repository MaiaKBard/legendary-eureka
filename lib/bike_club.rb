class BikeClub
  attr_reader :name, :bikers
  
  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    @bikers.max_by do |biker|
      biker.rides.values.size
    end
  end

  def best_time(ride)
    @bikers.min_by do |biker|
      biker.rides.values.min 
    end
  end

  def bikers_eligible(ride)
    # binding.pry
    @bikers.select do |biker|
      biker.acceptable_terrain.include?(ride.terrain) && 
      ride.total_distance <= biker.max_distance
    end
  end
end