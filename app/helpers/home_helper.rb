module HomeHelper
  def deck_color(passenger)
    if vessels?
      case passenger.deck
        when 'first_deck'
          'bg-orange'
        when 'second_deck'
          'bg-dark'
        when 'third_deck'
          'bg-green'
      end
    else
      passenger.main? ? 'bg-orange' : 'bg-dark'
    end
  end
end
