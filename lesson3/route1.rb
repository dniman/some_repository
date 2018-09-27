#
# Класс Route (Маршрут)
#

class Route
  attr_reader :initial_station, :finite_station, :stations

  def initialize(initial_station, finite_station)
    @initial_station = initial_station
    @finite_station = finite_station
    @stations = [initial_station, finite_station]
  end

  # Добавить промежуточную станцию
  # в список
  def add_station(station)
    @stations = stations.reduce([]) do |arr, st|
      unless st == finite_station
        arr << st
      else
        arr << station << finite_station
      end
    end
  end

  # Удалить промежуточную станцию
  # из списка
  def delete_station(station)
    unless station.eql?(initial_station) || station.eql?(finite_station)
      stations.delete(station)
    end  
  end

  # Вывод станций от начальной до конечной
  def show_stations
    stations.each {|station| puts station.name }
  end

end

