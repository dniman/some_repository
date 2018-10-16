# frozen_string_literal: true

require './menu'
require './menu/actions/route_actions'
require './menu/actions/common_actions'

class Menu
  module RoutesMenu
    include Actions::RouteActions
    include Actions::CommonActions

    def routes_menu
      @routes_menu ||= Menu.new.tap do |r|
        tap_routes_menu(r)
        tap_routes_menu_actions(r.actions)
      end
    end

    private

    def tap_routes_menu(menu)
      menu.header = 'Выберите действие: '
      tap_routes_menu_sections(menu.sections)
      menu.footer = '1/2/3/4/5/6: '
    end

    def tap_routes_menu_sections(sections)
      File.readlines('./routes_menu.txt').each do |line|
        sections << "  #{line.strip}"
      end
    end

    def tap_routes_menu_actions(actions)
      actions.concat([
                       create_route_action,
                       show_stations_action,
                       show_routes_action,
                       add_intermediate_station_to_route_action,
                       delete_intermediate_station_from_route_action,
                       exit_action
                     ])
    end
  end
end
