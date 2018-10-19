# frozen_string_literal: true

require './instance_counter'

# Route
class Route
  include InstanceCounter

  def initialize(initial_station, finite_station)
    @initial_station = initial_station
    @finite_station = finite_station
    @intermediate_stations = []
    register_instance
  end

  # Add intermediate station to list
  def add_station(station)
    intermediate_stations << station
  end

  # Delete intermediate station from list
  def delete_station(station)
    intermediate_stations.delete(station)
  end

  # Print stations list
  def show_stations
    stations.each { |station| puts station.name }
  end

  def stations
    [initial_station, intermediate_stations, finite_station].flatten
  end

  private

  attr_reader :initial_station, :finite_station, :intermediate_stations
end
