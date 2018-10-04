require './train'
require './passenger_carriage'

class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = "пассажирский"
  end

  # Прицепляем вагоны
  def add_carriage(carriage)
    super if passenger_carriage?(carriage)
  end
  
  private
  
  def passenger_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end  
end
