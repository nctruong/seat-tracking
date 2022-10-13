class Seat
  class << self
    def labels
      seat_list = gen_seat(9, letter = 'V')
      seat_list += gen_seat(64, letter = 'M')
      seat_list += gen_seat(118, letter = 'L')
      seat_list
    end

    private

    def gen_seat(max_num, letter = 'V')
      [*1..max_num].map { |num| "#{letter}#{num}" }
    end
  end
end
