module RouteActions
  def create_route_action
    lambda do
      print "Введите начальную станцию: "
      initial_station = gets.chomp
      print "Введите конечную станцию: "
      finite_station = gets.chomp
      App.create_route(initial_station, finite_station)
    end
  end

  def show_routes_action
    lambda do
      puts "Список доступных маршрутов: #{App.routes.length}"
      App.routes.each_with_index do |route,index|
        puts "  #{index + 1}.#{route.stations.join('-')}"
      end
      print "Нажмите любую клавишу для продолжения..."
      gets
    end
  end

  def add_intermediate_station_to_route_action
    lambda do
      return if App.routes.empty?
      puts "Выберите маршрут из списка: "
      routes_num = []
      App.routes.each_with_index do |route,index|
        routes_num << (index + 1)
        puts "  #{index + 1}.#{route.stations.join('-')}"
      end
      print routes_num.join("/") + ": "
      route_num = gets.chomp.to_i
      print "Введите промежуточный маршрут: "
      route = gets.chomp
      App.routes[route_num - 1].add_station(route)
    end
  end
  
  def delete_intermediate_station_from_route_action
    lambda do
      return if App.routes.empty?
      puts "Выберите маршрут из списка: "
      routes_num = []
      App.routes.each_with_index do |route,index|
        routes_num << (index + 1)
        puts "  #{index + 1}.#{route.stations.join('-')}"
      end
      print routes_num.join("/") + ": "
      route_num = gets.chomp.to_i
      print "Введите промежуточный маршрут: "
      route = gets.chomp
      App.routes[route_num - 1].delete_station(route)
    end
  end
end