# frozen_string_literal: true

require './manufacturer'

#
# Пассажирский вагон
#
class PassengerCarriage
  include Manufacturer

  def initialize(seats_count)
    @seats = *(1..seats_count)
    @booked_seats = []
  end

  # забронировать место
  def book_a_seat(seat)
    check_a_seat!(seat)
    booked_seats << seat
    seats.delete(seat)
  end

  # кол-во занятых мест в вагоне
  def booked_seats_count
    booked_seats.length
  end

  # кол-во свободных мест в вагоне
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
