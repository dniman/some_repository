# frozen_string_literal: true

require './train'
require './cargo_carriage'

#
# Грузовой поезд
#
class CargoTrain < Train
  # Прицепляем вагоны
  def add_carriage(carriage)
    super if cargo_carriage?(carriage)
  end

  private

  def cargo_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
