class Maze

  def initialize
    @maze = []
    @total_obstacles = rand(16) + 10
    @total_small_power_ups = 5
    @total_big_power_ups = 3
    randomize 
  end

  def height
    @maze[0].size
  end

  def width
    @maze.size
  end

  def get_pos(x, y)
    @maze[x-1][y-1]
  end

  def filter(cell_class)
    result = []
    @maze.each do |columns|
      columns.each do |cell|
        result << cell if cell.is_a? cell_class
      end
    end
    result
  end

  private

  def randomize 
    10.times { @maze << [] } 
    @maze.each do |columns|
      10.times { columns << Road.new }
    end

    @maze[0][0] = StartPosition.new
    @maze[9][9] = EndPosition.new

    while filter(Obstacle).size != @total_obstacles do
      x = rand(height)
      y = rand(width)
      if !(@maze[x][y].is_a? StartPosition or @maze[x][y].is_a? EndPosition)
        @maze[x][y] = Obstacle.new
      end
    end

    while filter(SmallPowerUp).size != @total_small_power_ups do
      x = rand(height)
      y = rand(width)
      if !(@maze[x][y].is_a? StartPosition or @maze[x][y].is_a? EndPosition or @maze[x][y].is_a? Obstacle)
        @maze[x][y] = SmallPowerUp.new
      end
    end

    while filter(BigPowerUp).size != @total_big_power_ups do
      x = rand(height)
      y = rand(width)
      if !(@maze[x][y].is_a? StartPosition or @maze[x][y].is_a? EndPosition or @maze[x][y].is_a? Obstacle or @maze[x][y].is_a? SmallPowerUp)
        @maze[x][y] = BigPowerUp.new
      end
    end

  end

end
