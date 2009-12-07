#
# A Simple Tic-Tac-Toe Game with jRuby and Java's Swing
#
# by CrociDB
# http://crocidb.com/
#

# It's gonna use java classes
require 'java'

# Using these classes
JFrame = javax.swing.JFrame
JPanel = javax.swing.JPanel
JButton = javax.swing.JButton
JLabel = javax.swing.JLabel
JOptionPane = javax.swing.JOptionPane

# Main Window Class
class Veia < JFrame
	
	# For the events...
	include java.awt.event.ActionListener
	
	# Constants
	C_V = 0
	C_X = 1
	C_O = 2

	def initialize
		super("jrVeia - by CrociDB")
		set_size(445,260)
		set_visible(true)
		set_default_close_operation(JFrame::EXIT_ON_CLOSE)
		set_layout(nil)
		
		# Current Player Attribute
		@playerx = true
		
		# Players points
		@points_player1 = 0
		@points_player2 = 0
		
		# Main Board Matrix
		@board = Array.new(9)
		
		# Building the interface
		build_interface
	end
	
	def build_interface
		# The panel with the buttons
		@main_panel = JPanel.new
		@main_panel.set_bounds(10, 10, 200, 200)
		@main_panel.set_layout(java.awt.GridLayout.new(3,3,10,10))
		
		add(@main_panel)
		
		# All the nine buttons
		@buttons = Array.new(9, JButton)
		
		9.times do |i|
			@buttons[i] = JButton.new ""
			@buttons[i].add_action_listener(self)
			@main_panel.add(@buttons[i])
			
			@board[i] = C_V
		end
		
		# The HUD
		@current_player = JLabel.new "Current Player: X"
		@current_player.set_bounds(220, 10, 100, 50)
		add(@current_player)
		
		@hud_player1 = JLabel.new "Player X: 0"
		@hud_player1.set_bounds(220, 90, 100, 20)
		add(@hud_player1)
		
		@hud_player2 = JLabel.new "Player O: 0"
		@hud_player2.set_bounds(220, 110, 100, 20)
		add(@hud_player2)
		
		# The reset button
		@reset = JButton.new "Reset Game"
		@reset.set_bounds(220, 140, 200, 30)
		@reset.add_action_listener(self)
		add(@reset)
		
		# The exit button	
		@exit = JButton.new "Exit"
		@exit.set_bounds(220, 180, 200, 30)
		@exit.add_action_listener(self)
		add(@exit)
	end
	
	# Events method
	def actionPerformed(e)
		# Check exit button
		if e.get_source == @exit
			puts "Now it should leave..."
			
			@board.each do |b|
				puts b
			end
		end
		
		# Check Reset Game button
		if e.get_source == @reset
			if JOptionPane.showConfirmDialog(nil, "Are you sure you want to reset the current game?") == 0
				reset_game
			end
		end
		
		# Check the buttons board		
		9.times do |i|
			if e.get_source == @buttons[i]
				if @playerx
					@buttons[i].set_text "X"
					@board[i] = C_X
				else
					@buttons[i].set_text "O"
					@board[i] = C_O
				end
			
				switch_current_player
			end
		end
	end
	
	# Switch the current player
	def switch_current_player
		if @playerx
			@playerx = false
			@current_player.set_text "Current Player: O"
		else
			@playerx = true
			@current_player.set_text "Current Player: X"
		end		
	end
	
	# This method resets the board and the points of the game
	def reset_game
		# Reset the board
		9.times do |i|
			@buttons[i].set_text("")
			@board[i] = C_V
		end
		
		# Reset the Points
		@points_player1 = 0
		@points_player2 = 0
		
		@hud_player1.set_text("Player X: 0")
		@hud_player2.set_text("Player O: 0")
		
		# Setting the X Player to start
		@playerx = true
		@current_player.set_text "Current Player: X"
	end
end

# Here is the magic... hehe
Veia.new
