# frozen_string_literal: true

require './menu'
require './menu/actions/main_menu_actions'
require './menu/actions/common_actions'

#
# Пространство имен
#
class Menu
  #
  # Основное меню
  #
  module MainMenu
    include Actions::MainMenuActions
    include Actions::CommonActions

    def main_menu
      @main_menu ||= Menu.new.tap do |m|
        tap_main_menu(m)
        tap_main_menu_actions(m.actions)
      end
    end

    private

    def tap_main_menu(menu)
      menu.header = 'Выберите раздел из списка: '
      tap_main_menu_sections(menu.sections)
      menu.footer = '1/2/3/4: '
    end

    def tap_main_menu_sections(sections)
      File.readlines('./main_menu.txt').each do |line|
        sections << "  #{line.strip}"
      end
    end

    def tap_main_menu_actions(actions)
      actions.concat([station_actions,
                      train_actions,
                      route_actions,
                      exit_action])
    end
  end
end
