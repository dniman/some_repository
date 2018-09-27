
class Train
  attr_reader :carriage_count, :speed, :current_station

  def initialize(number, type, carriage_count)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
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
  def increase_carriage
    @carriage_count += 1 unless speed > 0
  end

  # Отцепляем вагоны
  def decrease_carriage
    @carriage_count -= 1 unless speed > 0
  end

  # Назначаем маршрут
  def route=(route)
    @route = route
    self.current_station = route.stations.first
  end

  def move_forward
    unless current_station.eql?(route.stations.last)
      current_station.departure_train(self)
      self.current_station = route.stations[next_index]
    end 
  end

  def move_back
    unless current_station.eql?(route.stations.first)
      current_station.departure_train(self)
      self.current_station = route.stations[previous_index] 
    end
  end

  def current_station=(station)
    station.arrive_train(self)
    @current_station = station
  end

  def next_station
    route.stations[current_index + 1]
  end

  def prev_station
    route.stations[currend_index - 1]
  end

  private
  attr_reader :route

  def current_index
    route.stations.find_index(current_station)
  end

  def previous_index
    current_index - 1
  end

  def next_index
    current_index + 1
  end
end
