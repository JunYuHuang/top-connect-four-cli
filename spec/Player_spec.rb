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

  describe "#to_s" do
    it "returns the correct string if called with an optional ascii char" do
      player = Player.new(nil, "Player 1", :black)
      res = player.to_s("⚫")
      expected = "Player 1 (BLACK ⚫)"
      expect(res).to eql(expected)
    end

    it "returns the correct string if called no args" do
      player = Player.new(nil, "Player 1", :black)
      res = player.to_s
      expected = "Player 1 (BLACK)"
      expect(res).to eql(expected)
    end
  end
end
