# frozen_string_literal: true

require './manufacturer'
require './instance_counter'
require './validation'

# Train
class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^[а-я|\d]{3}-[а-я|\d]{2}\z|^[а-я|\d]{3}\z/

  attr_reader :number, :speed, :current_station, :carriages

  @@trains = {}

  def self.trains
    @@trains
  end

  def self.find(number)
    trains[number]
  end

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    self.class.trains[number] = self
    register_instance
    validate!
  end

  def speed_up(value)
    @speed += value
  end

  def speed_down(value)
    @speed = value > speed ? value - speed : 0
  end

  def add_carriage(carriage)
    carriages << carriage unless speed.positive?
  end

  def delete_carriage
    carriages.delete(carriages.last) unless speed.positive?
  end

  def route=(route)
    @route = route
    self.current_station = route.stations.first
  end

  def move_forward
    return unless last_station?

    current_station.departure_train(self)
    self.current_station = route.stations[next_index]
  end

  def move_back
    return unless first_station?

    current_station.departure_train(self)
    self.current_station = route.stations[previous_index]
  end

  def current_station=(station)
    station.arrive_train(self)
    @current_station = station
  end

  def next_station
    route.stations[next_index]
  end

  def prev_station
    route.stations[previous_index]
  end

  def type
    return 'пассажирский' if is_a?(PassengerTrain)
    return 'грузовой' if is_a?(CargoTrain)
  end

  def each_carriage
    carriages.each do |carriage|
      yield(carriage) if block_given?
    end
  end

  private

  attr_reader :route

  def matched_number?
    number =~ NUMBER_FORMAT
  end

  def last_station?
    current_station.eql?(route.stations.last)
  end

  def first_station?
    current_station.eql?(route.stations.first)
  end

  def current_index
    route.stations.find_index(current_station)
  end

  def previous_index
    current_index - 1
  end

  def next_index
    current_index + 1
  end

  protected

  attr_writer :carriages
end
