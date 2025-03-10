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
end

#   describe '#total_distance' do
#     it 'calculates double the distance if it is not a loop' do
#       expect(@ride1.total_distance).to eq(21.4)
#     end

#     it 'returns the distance if it is a loop' do
#       expect(@ride2.total_distance).to eq(14.9)
#     end
#   end
# end 