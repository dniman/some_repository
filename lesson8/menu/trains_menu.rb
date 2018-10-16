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
      sections.concat(['  1. Создать поезд',
                       '  2. Просмотреть список доступных поездов',
                       '  3. Добавить вагоны к поезду',
                       '  4. Отцепить вагоны от поезда',
                       '  5. Просмотреть список вагонов поезда',
                       '  6. Просмотреть список маршрутов',
                       '  7. Назначить маршрут поезду',
                       '  8. Переместить поезд по маршруту вперед',
                       '  9. Переместить поезд по маршруту назад',
                       '  10. Занять место/зарезервировать объем в поезде',
                       '  11. Вернуться в предыдущее меню'])
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
