require './lib/ride'
require './lib/biker'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end
  describe 'initialize' do
    it 'exsists' do
      expect(@biker).to be_a(Biker)
      expect(@biker2).to be_a(Biker)
    end
  end

  describe 'attributes' do
    it 'has a name and max distance' do
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)

      expect(@biker2.name).to eq("Athena")
      expect(@biker2.max_distance).to eq(15)
    end

    it 'has a hash of rides as the key and times as a value' do
      expect(@biker.rides).to eq({})
    end

    it 'has a an array of acceptable terrians' do
      expect(@biker.acceptable_terrain).to eq([])
    end
  end

  describe '#learn_terrain' do
    it 'adds terrains to acceptable_terrians array' do
      expect(@biker.acceptable_terrain).to eq([])
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)
      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end
  end

  describe '#log_ride' do
    it 'returns a hash with rides taken as the key and the value as an array of times for each ride' do
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)
      expect(@biker.rides).to eq({})
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      expected_output = {
        @ride1 => [92.5, 91.1],
        @ride2 => [60.9, 61.6]
      }

      expect(@biker.rides).to eq(expected_output)
    end

    it 'does not let you log a ride if biker does not know terrian' do
      expect(@biker2.rides).to eq({})
      @biker2.log_ride(@ride1, 97.0)
      @biker2.log_ride(@ride2, 67.0)
      expect(@biker2.rides).to eq({})
    end

    it 'does not let you bike over bikers max_distance' do
      @biker2.learn_terrain(:gravel)
      @biker2.learn_terrain(:hills)
      expect(@biker2.rides).to eq({})
      @biker2.log_ride(@ride1, 95.0)
      @biker2.log_ride(@ride2, 65.0)
      expected_output = {
        @ride2 => [65.0]
      }
      expect(@biker2.rides).to eq(expected_output) 
    end
  end

  describe '#personal_record' do
    before(:each) do
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      @biker2.learn_terrain(:gravel)
      @biker2.learn_terrain(:hills)
      @biker2.log_ride(@ride1, 95.0)
      @biker2.log_ride(@ride2, 65.0)
    end

    it 'returns the best time(lowest time) for each ride taken by the biker' do
      expect(@biker.personal_record(@ride1)).to eq(91.1)
      expect(@biker.personal_record(@ride2)).to eq(60.9)  
      expect(@biker2.personal_record(@ride2)).to eq(65.0)
    end

    it 'returns false if no rides were logged for the given ride' do
      expect(@biker2.personal_record(@ride1)).to eq(false)
    end
  end
end 
