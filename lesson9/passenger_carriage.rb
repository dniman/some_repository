# frozen_string_literal: true

require './manufacturer'

#
# Passenger Carriage
#
class PassengerCarriage
  include Manufacturer

  def initialize(seats_count)
    @seats = *(1..seats_count)
    @booked_seats = []
  end

  def book_a_seat(seat)
    check_a_seat!(seat)
    booked_seats << seat
    seats.delete(seat)
  end

  def booked_seats_count
    booked_seats.length
  end

  def seats_count
    seats.length
  end

  private

  attr_reader :booked_seats, :seats

  def check_a_seat!(seat)
    raise "Извините, место #{seat} уже занято." if booked_seats.include?(seat)
    raise "Место #{seat} не существует." unless all_seats.include?(seat)
  end

  def all_seats
    booked_seats.merge(seats)
  end
end
