# frozen_string_literal: true

require './menu'
require './menu/actions/station_actions'
require './menu/actions/common_actions'

#
# Пространство имен
#
class Menu
  #
  # Меню станции
  #
  module StationsMenu
    include Actions::StationActions
    include Actions::CommonActions

    def stations_menu
      @stations_menu ||= Menu.new.tap do |s|
        tap_stations_menu(s)
        tap_stations_menu_actions(s.actions)
      end
    end

    def tap_stations_menu(menu)
      menu.header = 'Выберите действие: '
      tap_stations_menu_sections(menu.sections)
      menu.footer = '1/2/3/4: '
    end

    def tap_stations_menu_sections(sections)
      sections.concat(['  1. Создать станцию',
                       '  2. Просмотреть список доступных станций',
                       '  3. Просмотреть список поездов на станции',
                       '  4. Вернуться в предыдущее меню'])
    end

    def tap_stations_menu_actions(actions)
      actions.concat([create_station_action,
                      show_stations_action,
                      show_station_trains_action,
                      exit_action])
    end
  end
end
