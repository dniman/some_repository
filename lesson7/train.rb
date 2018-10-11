require './manufacturer'
require './instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^[а-я|\d]{3}-[а-я|\d]{2}\z|^[а-я|\d]{3}\z/

  attr_reader :number, :speed, :current_station, :carriages

  @@trains = {}
  
  def self.trains
    @@trains
  end

  def self.find(number)
    trains[number]
  end      
  
  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    self.class.trains[number] = self
    register_instance
    validate!
  end

  # Увеличение скорости
  def speed_up(value)
    @speed += value
  end

  # Торможение
  def speed_down(value)
    @speed = value > speed ? value - speed : 0
  end
  
  # Прицепляем вагоны
  def add_carriage(carriage)
    self.carriages << carriage unless speed > 0 
  end

  # Отцепляем вагоны
  def delete_carriage
    carriages.delete(carriages.last) unless speed > 0
  end

  # Назначаем маршрут
  def route=(route)
    @route = route
    self.current_station = route.stations.first
  end

  def move_forward
    unless last_station?
      current_station.departure_train(self)
      self.current_station = route.stations[next_index]
    end 
  end

  def move_back
    unless first_station?
      current_station.departure_train(self)
      self.current_station = route.stations[previous_index] 
    end
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
    return "пассажирский" if self.is_a?(PassengerTrain)
    return "грузовой" if self.is_a?(CargoTrain)
  end

  def validate!
    raise "Номер поезда не может быть пустым!" if number.empty?
    raise "Номер поезда не соответствует формату!" unless number =~ NUMBER_FORMAT
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  # метод, который принимает блок и проходит по всем вагонам поезда (вагоны должны быть во внутреннем массиве), 
  # передавая каждый объект вагона в блок.
  def each_carriage
    carriages.each do |carriage|
      yield(carriage) if block_given?
    end
  end

  protected :validate!

  private
  attr_reader :route
  
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
