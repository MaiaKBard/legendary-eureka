require './lib/ride'
require './lib/biker'
require './lib/bike_club'
require 'pry'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Biker do
  before(:each) do
    @club = BikeClub.new("#1 Riders")
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

    @biker.learn_terrain(:hills)
    @biker.learn_terrain(:gravel)
    @biker.log_ride(@ride1, 92.5)
    @biker.log_ride(@ride1, 91.1)
    @biker.log_ride(@ride2, 60.9)

    @biker2.learn_terrain(:hills)
    @biker2.learn_terrain(:gravel)
    @biker2.log_ride(@ride1, 95.0)
    @biker2.log_ride(@ride2, 65.0)
  end

  describe 'initialize' do
    it 'exsists' do
      expect(@club).to be_a(BikeClub)
    end
  end

  describe 'attributes' do
    it 'has a name' do
      expect(@club.name).to eq("#1 Riders")
    end

    it 'has a an array for bikers in the club' do
      expect(@club.bikers).to eq([])
    end
  end

  describe '#add_biker' do
    it 'adds biker biker into the bikers array' do
      expect(@club.bikers).to eq([])
      @club.add_biker(@biker)
      @club.add_biker(@biker2)
      expect(@club.bikers).to eq([@biker, @biker2])
    end
  end

  describe '#most_rides' do
    it 'returns the biker with the most rides logged' do
      expect(@club.bikers).to eq([])
      @club.add_biker(@biker)
      @club.add_biker(@biker2)
      expect(@club.bikers).to eq([@biker, @biker2])
      expect(@club.most_rides).to eq(@biker)
    end
  end

  describe '#best_time' do
    it 'returns the biker with the the best(lowest time) each ride given' do
      expect(@club.bikers).to eq([])
      @club.add_biker(@biker)
      @club.add_biker(@biker2)
      expect(@club.bikers).to eq([@biker, @biker2])
      expect(@club.best_time(@ride1)).to eq(@biker)
      expect(@club.best_time(@ride2)).to eq(@biker)
    end
  end

  describe '#bikers_eligible' do
    it 'returns the bikers eligible for a ride given' do
      expect(@club.bikers).to eq([])
      @club.add_biker(@biker)
      @club.add_biker(@biker2)
      expect(@club.bikers).to eq([@biker, @biker2])
      expect(@club.bikers_eligible(@ride1)).to eq([@biker])
      expect(@club.bikers_eligible(@ride2)).to eq([@biker, @biker2])
    end
  end
end
