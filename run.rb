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

start_pos = maze.filter(StartPosition)[0]
start_pos = maze.find_cell_pos(start_pos)

end_pos = maze.filter(EndPosition)[0]
end_pos = maze.find_cell_pos(end_pos)

start       = { 'x' => start_pos[0], 'y' => start_pos[1] }
destination = { 'x' => end_pos[0], 'y' => end_pos[1] }


obstacles = maze.filter(Obstacle)
obstacles_pos = []
obstacles.each do |o| 
  obstacles_pos << maze.find_cell_pos(o)
end


bot = Bot.new

pathfinder  = Astar.new(start, destination, obstacles_pos, bot)
result      = pathfinder.search

painted_paths = []

result.each do |node|
  system('clear')

  unless bot.is_killed
    bot.decrement_hp 3
    bot.hp += 5 if maze.get_pos(node.x+1, node.y+1).is_a? SmallPowerUp
    bot.hp += 10 if maze.get_pos(node.x+1, node.y+1).is_a? BigPowerUp 
    bot.hp = 0 if bot.hp < 0
    puts "Pontos de vida: #{bot.hp}"
    painted_paths << [node.x, node.y] 
  else
    puts "O robo morreu".red
  end
  
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




