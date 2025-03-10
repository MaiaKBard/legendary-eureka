class Biker
  attr_reader :name, :max_distance, :rides, :acceptable_terrain

  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @rides = Hash.new
    @acceptable_terrain = []
  end

  def learn_terrain(terrain)
    @acceptable_terrain << terrain 
  end

  def log_ride(ride, time)
    return unless @acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance

    if @rides[ride]
      @rides[ride] << time
    else 
      @rides[ride] = [time]
    end
  end

  def personal_record(ride)
    return false unless @rides[ride]
    @rides[ride].min
  end
end