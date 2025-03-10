require './lib/ride'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Ride do
  before(:each) do
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
  end
  describe 'initialize' do
    it 'exsists' do
      expect(@ride1).to be_a(Ride)
      expect(@ride2).to be_a(Ride)
    end
  end

  describe 'attributes' do
    it 'has a name, distance, loop, and terrain' do
      expect(@ride1.name).to eq("Walnut Creek Trail")
      expect(@ride1.distance).to eq(10.7)
      expect(@ride1.loop).to eq(false)
      expect(@ride1.terrain).to eq(hills)

      expect(@ride1.name).to eq("Town Lake")
      expect(@ride1.distance).to eq(14.9)
      expect(@ride1.loop).to eq(true)
      expect(@ride1.terrain).to eq(gravel)
    end
  end
end 