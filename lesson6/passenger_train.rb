require './train'
require './passenger_carriage'

class PassengerTrain < Train

  # Прицепляем вагоны
  def add_carriage(carriage)
    super if passenger_carriage?(carriage)
  end
  
  private
  
  def passenger_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end  
end
