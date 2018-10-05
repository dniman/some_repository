require './train'
require './cargo_carriage'

class CargoTrain < Train

  def initialize(name)
    super(name, "грузовой")
  end

  # Прицепляем вагоны
  def add_carriage(carriage)
    super if cargo_carriage?(carriage)
  end
  
  private
  
  def cargo_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
