# frozen_string_literal: true

class Menu
  module Actions
    module MainMenuActions
      def station_actions
        lambda do
          App.new.tap do |a|
            a.start(a.stations_menu)
          end
        end
      end

      def train_actions
        lambda do
          App.new.tap do |a|
            a.start(a.trains_menu)
          end
        end
      end

      def route_actions
        lambda do
          App.new.tap do |a|
            a.start(a.routes_menu)
          end
        end
      end
    end
  end
end
