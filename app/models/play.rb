class Play
  def draw_hand(deck)
    @lib  = []
    @hand = []
    @lib = deck.library.each do |card|
      @lib << card
    end
    @lib.shuffle!
    7.times do
      @hand << @lib.shift
    end
    @hand
  end

end
