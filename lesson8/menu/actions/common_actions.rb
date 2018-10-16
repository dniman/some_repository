# frozen_string_literal: true

class Menu
  module Actions
    module CommonActions
      def exit_action
        -> { raise StopIteration }
      end
    end
  end
end
