require "maze"
require "cell"
require "road"
require "end_pos"
require "start_pos"
require "obstacle"
require "power_ups/big_power_up"
require "power_ups/small_power_up"

describe Maze do
  
  before :context do 
    @maze = Maze.new
  end

  context "should be" do

    it "height 10" do
      expect(@maze.height).to eq(10)
    end
    
    it "width 10" do
      expect(@maze.width).to eq(10)
    end

    it "start position 1, 1" do
      expect(@maze.get_pos(1, 1).class).to eq(StartPosition)
    end

    it "end position 10, 10" do
      expect(@maze.get_pos(10, 10).class).to eq(EndPosition)
    end

    it "10 ~ 25 obstacles" do
      obstacles = @maze.filter(Obstacle)
      expect(obstacles.size).to be >= 10
      expect(obstacles.size).to be <= 25
    end

    it "5 small power ups" do
      small_power_ups = @maze.filter(SmallPowerUp)
      expect(small_power_ups.size).to eq(5)
    end

    it "3 big power ups" do
      big_power_ups = @maze.filter(BigPowerUp)
      expect(big_power_ups.size).to eq(3)
    end

    it "cell pos" do
      cell = @maze.get_pos(3, 4)
      pos = @maze.find_cell_pos(cell)
      expect(pos).to eq([2, 3])
    end

  end

end
