class Game
  def initialize(library, hand)
    @library = library
    @hand = hand
  end

  def hand
    @hand
  end

  def library
    @library
  end

  def mulligan
    # binding.pry
    if self.hand.empty?
      @library.shuffle!
      @hand = @library.shift(7).flatten
    else
      i = self.hand.size
      @library = @library + @hand.shift(i)
      i -= 1
      @library.shuffle!
      @hand = @library.shift(i).flatten
    end
    @game = Game.new(@library, @hand)
    @game
  end
end
