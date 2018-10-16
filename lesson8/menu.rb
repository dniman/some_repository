# frozen_string_literal: true

#
# Класс Menu
#
class Menu
  attr_accessor :header, :footer
  attr_reader :sections, :section_num, :actions

  def initialize
    @sections = []
    @actions = []
  end

  def ask_section
    gets.chomp.to_i
  end

  def show
    print to_s
  end

  def select_action(num)
    actions[num - 1].call
  end

  def activate!
    show
    select_action(ask_section)
  end

  def to_s
    [header, sections, footer].flatten.join("\n")
  end
end
