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
    self.carriages << carriage if passenger_carriage?(carriage) && speed.eql?(0)
  end
  
  private
  
  def passenger_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end  
end
