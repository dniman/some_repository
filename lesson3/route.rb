#
# Класс Route (Маршрут)
#

class Route

  def initialize(initial_station, finite_station)
    @initial_station = initial_station
    @finite_station = finite_station
    @intermediate_stations = []
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

  private
    attr_reader :initial_station, :finite_station, :intermediate_stations
end
