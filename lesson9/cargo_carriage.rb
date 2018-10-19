# frozen_string_literal: true

require './manufacturer'

# Cargo carriage
class CargoCarriage
  include Manufacturer
  attr_accessor :capacity, :allocated_capacity

  def initialize(capacity)
    @capacity = capacity
    @allocated_capacity = 0
  end

  def allocate(capacity)
    if capacity > self.capacity
      raise "Запрашиваемый объем #{capacity} не доступен. "\
      "Доступно #{self.capacity}"
    end

    self.allocated_capacity += capacity
    self.capacity -= capacity
  end
end
