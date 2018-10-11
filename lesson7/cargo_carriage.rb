require './manufacturer'

class CargoCarriage
  include Manufacturer
  attr_accessor :capacity, :allocated_capacity

  def initialize(capacity)
    @capacity = capacity
    @allocated_capacity = 0
  end

  # Занять объем
  def allocate(capacity)
    raise "Запрашиваемый объем #{capacity} не доступен. Доступно #{self.capacity}" if capacity > self.capacity
    self.allocated_capacity += capacity
    self.capacity -= capacity
  end

end
