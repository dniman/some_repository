require './train'
require './cargo_carriage'

class CargoTrain < Train
  attr_reader :type

  def initialize(name)
    super(name)
    @type = "грузовой"
  end

  # Прицепляем вагоны
  def add_carriage(carriage)
    self.carriages << carriage if cargo_carriage?(carriage) && speed.eql?(0)
  end
  
  private
  
  def cargo_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
