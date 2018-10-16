# frozen_string_literal: true

require './menu'
require './menu/actions/train_actions'
require './menu/actions/common_actions'

class Menu
  #
  # Меню поезда
  #
  module TrainsMenu
    include Actions::TrainActions
    include Actions::CommonActions

    def trains_menu
      @trains_menu ||= Menu.new.tap do |t|
        tap_trains_menu(t)
        tap_trains_menu_actions(t.actions)
      end
    end

    def tap_trains_menu(menu)
      menu.header = 'Выберите действие: '
      tap_trains_menu_sections(menu.sections)
      menu.footer = '1/2/3/4/5/6/7/8/9/10/11: '
    end

    def tap_trains_menu_sections(sections)
      File.readlines('./trains_menu.txt').each do |line|
        sections << "  #{line.strip}"
      end
    end

    def tap_trains_menu_actions(actions)
      actions.concat([create_train_action, show_trains_action,
                      add_carriage_to_train_action,
                      delete_carriage_from_train_action,
                      show_train_carriages_action,
                      show_routes_action, set_route_to_train_action,
                      move_train_ahead_action, move_train_back_action,
                      book_seat_allocate_capacity_action,
                      exit_action])
    end
  end
end
