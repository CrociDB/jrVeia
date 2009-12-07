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
JButton = javax.swing.JButton

# Main Window Class
class Veia < JFrame
	
	# For the events...
	include java.awt.event.ActionListener

	def initialize(title)
		super(title)
		set_size(640,480)
		set_visible(true)
		set_default_close_operation(JFrame::EXIT_ON_CLOSE)
		set_layout(nil)
		
		# Building the interface
		build_interface
	end
	
	def build_interface
		@exit = JButton.new "Exit"
		@exit.set_bounds(10, 10, 100, 100)
		@exit.add_action_listener(self)
		
		add(@exit)
	end
	
	# Events method
	def actionPerformed(e)
		if e.get_source == @exit
			puts "teste"
		end
	end
end

# Here is the magic... hehe
Veia.new "Teste"
