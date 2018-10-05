class Train
  attr_reader :number, :type, :speed, :current_station, :carriages

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
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
