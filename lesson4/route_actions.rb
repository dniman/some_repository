module RouteActions
  def create_route_action
    lambda do
      if App.stations.length < 2
        puts "Список доступных станций: #{App.stations.length}"
        print "Нажмите любую клавишу для продолжения..."
        gets
        return
      end

      puts "Выберите начальную станцию из списка: "
      initial_nums = []
      App.stations.each_with_index do |station, index|
        initial_nums << index + 1
        puts "  #{index + 1}.#{station.name}"
      end
      print "#{initial_nums.join("/")}: "
      initial_num = gets.chomp.to_i

      puts "Выберите конечную станцию из списка: "
      finite_nums = []
      available_stations = App.stations - [App.stations[initial_num - 1]]
      available_stations.each_with_index do |station, index|
        finite_nums << index + 1
        puts "  #{index + 1}.#{station.name}"
      end
      print "#{finite_nums.join("/")}: "
      finite_num = gets.chomp.to_i
      finite_index = App.stations.find_index(available_stations[finite_num - 1])

      App.create_route(initial_num - 1, finite_index)
    end
  end

  def show_routes_action
    lambda do
      puts "Список доступных маршрутов: #{App.routes.length}"
      App.routes.each_with_index do |route, index|
        station_names = route.stations.map {|station| station.name }
        puts "  #{index + 1}.#{station_names.join('-')}"
      end
      print "Нажмите любую клавишу для продолжения..."
      gets
    end
  end

  def add_intermediate_station_to_route_action
    lambda do
      if App.routes.empty?
        puts "Список доступных маршрутов: #{App.routes.length}"
        print "Нажмите любую клавишу для продолжения..."
        gets
      end

      puts "Выберите маршрут из списка: "
      routes_num = []
      App.routes.each_with_index do |route,index|
        routes_num << (index + 1)
        station_names = route.stations.map {|station| station.name }
        puts "  #{index + 1}.#{station_names.join('-')}"
      end
      print routes_num.join("/") + ": "
      route_num = gets.chomp.to_i
      route = App.routes[route_num - 1]

      available_stations = App.stations - route.stations
      if available_stations.empty?
        puts "Список доступных станций: #{available_stations.length}"
        print "Нажмите любую клавишу для продолжения..."
        gets
        return
      end

      print "Выберите промежуточную станцию из списка: "
      nums = []
      available_stations.each_with_index do |station, index|
        nums << index + 1
        puts "  #{index + 1}.#{station.name}"
      end
      print "#{nums.join("/")}: "
      num = gets.chomp.to_i

      station = available_stations[num - 1]
      App.routes[route_num - 1].add_station(station)
    end
  end
  
  def delete_intermediate_station_from_route_action
    lambda do
      if App.routes.empty?
        puts "Список доступных маршрутов: #{App.routes.length}"
        print "Нажмите любую клавишу для продолжения..."
        gets
      end
      
      puts "Выберите маршрут из списка: "
      routes_num = []
      App.routes.each_with_index do |route,index|
        routes_num << (index + 1)
        station_names = route.stations.map {|station| station.name }
        puts "  #{index + 1}.#{station_names.join('-')}"
      end
      print routes_num.join("/") + ": "
      route_num = gets.chomp.to_i
      route = App.routes[route_num - 1]

      available_stations = route.stations - [route.stations.first, route.stations.last]
      if available_stations.empty?
        puts "Список доступных станций: #{available_stations.length}"
        print "Нажмите любую клавишу для продолжения..."
        gets
        return
      end

      print "Выберите промежуточную станцию из списка: "
      nums = []
      available_stations.each_with_index do |station, index|
        nums << index + 1
        puts "  #{index + 1}.#{station.name}"
      end
      print "#{nums.join("/")}: "
      num = gets.chomp.to_i

      station = available_stations[num - 1]
      App.routes[route_num - 1].delete_station(station)
    end
  end
end
