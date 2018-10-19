# frozen_string_literal: true

require './train'
require './cargo_carriage'

#
# Cargo train
#
class CargoTrain < Train
  def add_carriage(carriage)
    super if cargo_carriage?(carriage)
  end

  private

  def cargo_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
