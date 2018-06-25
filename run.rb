require "./lib/astar"
require "./lib/bot"
require "./lib/maze"
require "./lib/cell"
require "./lib/road"
require "./lib/end_pos"
require "./lib/start_pos"
require "./lib/obstacle"
require "./lib/power_ups/big_power_up"
require "./lib/power_ups/small_power_up"
require "colorize"
require "byebug"

maze = Maze.new

start       = { 'x' => 0, 'y' => 0 }
destination = { 'x' => 9, 'y' => 9 }


obstacles = maze.filter(Obstacle)
obstacles_pos = []
obstacles.each do |o| 
  obstacles_pos << maze.find_cell_pos(o)
end


bot = Bot.new

pathfinder  = Astar.new(start, destination, obstacles_pos, bot)
result      = pathfinder.search

#obstacle = Astar_Node.new(2, 2, 3, 2, 3, 2)
#byebug



painted_paths = []

result.each do |node|
  system('clear')
  
  bot.hp = 0 if bot.hp < 0
  puts "Pontos de vida: #{bot.hp}"

  painted_paths << [node.x, node.y] if bot.hp > 0
  bot.hp -= 3
  maze.get_maze.each do |columns|
    line = ''
    columns.each do |cell|
      if painted_paths.include? maze.find_cell_pos(cell)
        line << '  '.colorize(background: :yellow, color: :red)
      elsif cell.is_a? Obstacle
        line << '  '.colorize(background: :black, color: :red)
      elsif cell.is_a? SmallPowerUp 
        line << '05'.colorize(background: :white, color: :green)
      elsif cell.is_a? BigPowerUp 
        line << '10'.colorize(background: :white, color: :green)
      elsif cell.is_a? StartPosition 
        line << '  '.colorize(background: :blue, color: :green)
      elsif cell.is_a? EndPosition 
        line << '  '.colorize(background: :red, color: :green)
      else
        line << '  '.colorize(background: :white, color: :red)
      end
    end
    puts line
  end
  sleep 0.1
end




