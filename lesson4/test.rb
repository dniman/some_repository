class Menu
  attr_accessor :header, :footer
  attr_reader :sections, :section
  
  def initialize
    @sections = []
  end

  def section
    @section ||= gets.chomp.to_i
  end

  def to_s
    [header, sections, footer].flatten.join("\n")
  end
end

main_menu = Menu.new.tap do |m|
    m.header = "Выберите раздел из списка: "
    m.sections << "1. Раздел станции"
    m.sections << "2. Раздел поезда"
    m.sections << "3. Раздел маршруты"
    m.sections << "4. Выйти"
    m.footer = "1/2/3/4: "
end

p main_menu