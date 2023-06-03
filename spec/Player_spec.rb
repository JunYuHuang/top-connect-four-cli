require './lib/Player'

describe Player do
  describe "#piece" do
    it "returns its piece value or property" do
      player = Player.new(nil, "Player 1", :black)
      expect(player.piece).to eql(:black)
    end
  end

  describe "#name" do
    it "returns its name value or property" do
      player = Player.new(nil, "Player 1", :black)
      expect(player.name).to eql("Player 1")
    end
  end
end
