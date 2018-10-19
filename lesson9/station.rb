# frozen_string_literal: true

require './instance_counter'
require './validation'

# Station
class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @all = []

  class << self
    attr_reader :all
  end

  validate :name, :presence
  validate :name, :type, String

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self
    register_instance
    validate!
  end

  def arrive_train(train)
    trains << train
  end

  def departure_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def each_train
    trains.each do |train|
      yield(train) if block_given?
    end
  end
end
