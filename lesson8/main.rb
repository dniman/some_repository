# frozen_string_literal: true

require './app'

system('clear')
app = App.new
app.start(app.main_menu)
