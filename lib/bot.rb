class Bot

  attr_accessor :hp
  attr_reader :is_killed

  def initialize
    @hp = 50
    @is_killed = false 
  end

  def decrement_hp(num)
    @hp -= num
    kill if @hp <= 0
  end

  def kill
    @is_killed = true
  end

end
