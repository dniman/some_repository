require './instance_counter'
#
# Класс Route (Маршрут)
#

class Route
  include InstanceCounter

  def initialize(initial_station, finite_station)
    @initial_station = initial_station
    @finite_station = finite_station
    @intermediate_stations = []
    register_instance
    validate!
  end

  # Добавить промежуточную станцию
  # в список
  def add_station(station)
    intermediate_stations << station
  end

  # Удалить промежуточную станцию
  # из списка
  def delete_station(station)
    intermediate_stations.delete(station)
  end

  # Вывод станций от начальной до конечной
  def show_stations
    stations.each {|station| puts station.name }
  end

  def stations
    [initial_station, intermediate_stations, finite_station].flatten
  end

  def validate!
    raise "Не указана начальная станция!" unless initial_station 
    raise "Не указана конечная станция!" unless finite_station 
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private
    attr_reader :initial_station, :finite_station, :intermediate_stations
end
