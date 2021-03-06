#!/usr/bin/jruby

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
System = java.lang.System

# Main Window Class
class Veia < JFrame
	
	# For the events...
	include java.awt.event.ActionListener
	
	# Constants
	C_V = 0
	C_X = 1
	C_O = 2
		
	def initialize
		super("Tic-Tac-Toe")
		set_size(445,260)
		set_default_close_operation(JFrame::EXIT_ON_CLOSE)
		set_layout(nil)
		
		# Current Player Attribute
		@playerx = true
		
		# Players points
    	@points_player1 = 0
    	@points_player2 = 0
    	
		# Main Board Matrix
		@board = Array.new(9)
		
		# Number of moves
		@moves = 0
		
		# Building the interface
		build_interface
		set_visible(true) #better this way
	end
	
	def build_interface
		# The panel with the buttons
		@main_panel = JPanel.new
		@main_panel.set_bounds(10, 10, 200, 200)
		@main_panel.set_layout(java.awt.GridLayout.new(3,3,10,10))
		
		add(@main_panel)
		
		# All the nine buttons
		@buttons = Array.new(9)
		
		9.times do |i|
			@buttons[i] = JButton.new("")
			@buttons[i].add_action_listener(self)
			@main_panel.add(@buttons[i])
			
			@board[i] = C_V
		end
		
		# The HUD
		@current_player = JLabel.new "Player: X"
		@current_player.set_bounds(220, 10, 100, 50)
		add(@current_player)
		
		@hud_player1 = JLabel.new "Player X: "+@points_player1.to_s
		@hud_player1.set_bounds(220, 90, 100, 20)
		add(@hud_player1)
		
		@hud_player2 = JLabel.new "Player O: "+@points_player2.to_s
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
		    JOptionPane.showMessageDialog nil,"Bye-bye"
		    System.exit(JFrame::EXIT_ON_CLOSE)
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
				if @playerx and @board[i] == C_V
					@buttons[i].set_text "X"
					@board[i] = C_X
					switch_current_player
    				@moves += 1
				elsif @board[i] == C_V
					@buttons[i].set_text "O"
					@board[i] = C_O
					switch_current_player
    				@moves += 1
				end
				if @moves > 4
				    check_board
			    end
				@hud_player1.set_text("Player X: "+@points_player1.to_s)
            	@hud_player2.set_text("Player O: "+@points_player2.to_s)
			end
		end
	end
	
	# Switch the current player
	def switch_current_player
		if @playerx
			@playerx = false
			@current_player.set_text("Player: O")
		else
			@playerx = true
			@current_player.set_text("Player: X")
		end		
	end
	
	# This method resets the board and the points of the game
	def reset_game
		#Reset the board
		reset_board
		
		# Reset the Points
		@points_player1 = 0
		@points_player2 = 0
		
		@hud_player1.set_text("Player X: "+@points_player1.to_s)
		@hud_player2.set_text("Player O: "+@points_player2.to_s)
		
		# Setting the X Player to start
		@playerx = true
		@current_player.set_text "Player: X"
	end
	
	#This method resets the board
	def reset_board
        # Reset the board
		9.times do |i|
			@buttons[i].set_text("")
			@board[i] = C_V
		end
    end
	
	# Gets the position of the Vector by a given Matrix coordinates
	# x for row and y for column
	def vector_value(x, y)
		@board[x+y*3]
	end
	
	# Checks the board to get the winner
    def check_board	
        # Winner checker
        @winner = false
        
        # Board's status
        @empty_board = false

        # Checking the rows
        3.times do |x|
            if !@winner
                if vector_value(x,0) == vector_value(x,1) and vector_value(x,1) == vector_value(x,2) and vector_value(x,2) != C_V
                    if vector_value(x,2) == C_X
                        JOptionPane.showMessageDialog nil,"Player X is the winner!"
                        @points_player1 += 1
                    elsif vector_value(x,2) == C_O
                        JOptionPane.showMessageDialog nil,"Player O is the winner!"
                        @points_player2 += 1
                    end
                    reset_board
                    @moves = 0
                    @winner = true
                end
            end
        end

        #Checking the columns
        if !@winner
            3.times do |y|
                if !@winner
                    if vector_value(0,y) == vector_value(1,y) and vector_value(1,y) == vector_value(2,y) and vector_value(2,y) != C_V 
                        if vector_value(2,y) == C_X
                            JOptionPane.showMessageDialog nil,"Player X is the winner!"
                            @points_player1 += 1
                        elsif vector_value(2,y) == C_O
                            JOptionPane.showMessageDialog nil,"Player O is the winner!"
                            @points_player2 += 1
                        end 
                        reset_board
                        @moves = 0
                        @winner = true
                    end
                end
            end
        end

        #Checking the diagonals
        if !@winner
            if vector_value(0,0) == vector_value(1,1) and vector_value(1,1) == vector_value(2,2) and vector_value(2,2) != C_V
                if vector_value(2,2) == C_X
                    JOptionPane.showMessageDialog nil,"Player X is the winner!"
                    @points_player1 += 1
                elsif vector_value(2,2) == C_O
                    JOptionPane.showMessageDialog nil,"Player O is the winner!"
                    @points_player2 += 1
                end
                reset_board
                @moves = 0
                @winner = true
            elsif vector_value(0,2) == vector_value(1,1) and vector_value(1,1) == vector_value(2,0) and vector_value(2,0) != C_V
                if vector_value(2,0) == C_X
                    JOptionPane.showMessageDialog nil,"Player X is the winner!"
                    @points_player1 += 1
                elsif vector_value(2,0) == C_O
                    JOptionPane.showMessageDialog nil,"Player O is the winner!"
                    @points_player2 += 1
                end
                reset_board
                @moves = 0
                @winner = true
            else #Checking no winner
                @board.each do |i|
                    if i == C_V
                        @empty_board = true
                        break
                    end
                end
                if !@empty_board
                    JOptionPane.showMessageDialog nil, "No winner, the game will restart"
                    reset_board
                    @moves = 0
                end
            end
        end
    end
end

# Here is the magic... hehe
Veia.new