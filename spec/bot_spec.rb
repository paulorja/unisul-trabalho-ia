require "bot"

describe Bot do 

  before :context do
    @bot = Bot.new
  end

  context "should be" do

    it "50 life points" do
      expect(@bot.hp).to eq(50)
    end

  end

end
