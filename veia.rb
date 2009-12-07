#
# A Simple Tic-Tac-Toe Game with jRuby and Java's Swing
#
# by CrociDB
# http://crocidb.com/
#

# It's gonna use java classes
require 'java'

# Using this classes
JFrame = javax.swing.JFrame
JPanel = javax.swing.JPanel
JButton = javax.swing.JButton

# Main Window Class
class Veia < JFrame
	
	# For the events...
	include java.awt.event.ActionListener

	def initialize
		super("jrVeia - by CrociDB")
		set_size(445,260)
		set_visible(true)
		set_default_close_operation(JFrame::EXIT_ON_CLOSE)
		set_layout(nil)
		
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
		end
		
		# The exit button	
		@exit = JButton.new "Exit"
		@exit.set_bounds(220, 180, 200, 30)
		@exit.add_action_listener(self)
		
		add(@exit)
	end
	
	# Events method
	def actionPerformed(e)
		if e.get_source == @exit
			puts "Now it should leave..."
		end
		
		@buttons.each { |b|
			if e.get_source == b
				b.set_text "X"
			end
		}
	end
end

# Here is the magic... hehe
Veia.new
