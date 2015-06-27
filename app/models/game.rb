class Game
  def initialize(library, hand)
    @library = library
    @hand    = hand
  end

  def hand
    @hand
  end

  def library
    @library
  end

  def mulligan
    if self.hand.empty?
      @library.shuffle!
      @hand = @library.shift(7).flatten
    else
      i        = self.hand.size
      @library = @library + @hand.shift(i)
      i -= 1
      @library.shuffle!
      @hand = @library.shift(i).flatten
    end
    @game = Game.new(@library, @hand)
    @game
  end

  def draw(*num)
    num          = [1] if num.empty?
    @cards_drawn = []
    @cards_drawn << @library.shift(num.first)
    @hand        = @hand + @cards_drawn.flatten
    @cards_drawn
  end
end
