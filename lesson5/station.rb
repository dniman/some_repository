require './instance_counter'
# 
# Класс Station (Станция):
#

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @all = []

  class << self
    attr_reader :all
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self
    register_instance
  end

  # принимать поезда по одному за раз
  def arrive_train(train)
    trains << train
  end

  # отправлять поезда по одному за раз
  def departure_train(train)
    trains.delete(train)
  end

  # Может возвращать список поездов на станции по типу: кол-во грузовых, пассажирских
  def trains_by_type(type) 
    trains.select { |train| train.type == type }
  end

end
