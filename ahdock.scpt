------------------------------------------------------------------------------
-- File : ahdock.scpt 
-- Author : banjuanshu  <jibao3436@gmail.com>
--
--
-- Copyright (c) 2015 banjuanshu     (http://banjuanshu.com)
--
------------------------------------------------------------------------------
-- Adds intellihide function to the Dock

-- Check if GUI scripting is enabled
-- Otherwise, open System Preferences
-- and invite the user to set it
tell application "System Events" to set isUIScriptingEnabled to UI elements enabled

if isUIScriptingEnabled = false then
	tell application "System Preferences"
		activate
		set current pane to pane "com.apple.preference.security"
		display dialog "Your system is not properly configured to run this script.  
Please select the \"Enable access for assistive devices\" 
checkbox and trigger the script again to proceed."
		return
	end tell
end if

-- Actual intellihide implementation
set loop_delay to 0.5

-- Original Desktop size
set Desk_w to item 3 of getDesktopBounds()
set Desk_h to item 4 of getDesktopBounds()

-- Original Dock size, orientation and position
set Dock_o to getDockOrientation()
set Dock_w to item 1 of getDockSize()
set Dock_h to item 2 of getDockSize()
set Dock_x to item 1 of getDockPos()
set Dock_y to item 2 of getDockPos()
-- Get current value for Desktop and Dock
set Desk_w_ to item 3 of getDesktopBounds()
set Desk_h_ to item 4 of getDesktopBounds()
set Dock_o_ to getDockOrientation()
set Dock_w_ to item 1 of getDockSize()
set Dock_h_ to item 2 of getDockSize()

-- Main loop
repeat until false
	try
		with timeout of loop_delay seconds
			
			-- Some items have changed, recompute Dock position
			if not Desk_w_ = Desk_w or not Desk_h_ = Desk_h or not Dock_o_ = Dock_o or not Dock_w_ = Dock_w or not Dock_h_ = Dock_h then
				
				set Dock_x_ to item 1 of getDockPos()
				set Dock_y_ to item 2 of getDockPos()
				
			else
				set Dock_x_ to Dock_x
				set Dock_y_ to Dock_y
			end if
			
			-- Loop around windows of the frontmost application
			tell application "System Events"
				try
					-- By default, do not hide the dock
					set hide to false
					
					repeat with w in every window of (application processes whose visible is true)
						
						-- Information about the window
						set W_descr to the description of w
						
						-- Avoid dialog and minimized windows
						if W_descr is not equal to "dialog" then
							
							set w_size to the size of w
							set W_w to item 1 of w_size
							set W_h to item 2 of w_size
							
							set W_pos to the position of w
							set W_x to item 1 of W_pos
							set W_y to item 2 of W_pos
							
							set r1x1 to W_x
							set r1y1 to W_y
							set r1x2 to W_x + W_w
							set r1y2 to W_y + W_h
							
							set r2x1 to Dock_x_
							set r2y1 to Dock_y_
							set r2x2 to Dock_x_ + Dock_w_
							set r2y2 to Dock_y_ + Dock_h_
							
							if (r1x2 is greater than r2x1) and (r1y2 is greater than r2y1) and (r2x2 is greater than r1x1) and (r2y2 is greater than r1y1) then
								set hide to true
								exit repeat
							end if
						else
							set hide to autohide of dock preferences
						end if
					end repeat
					
					set hide2 to autohide of dock preferences
					
					if hide is not equal to hide2 then
						if hide then
							set the autohide of the dock preferences to true
						else
							set the autohide of the dock preferences to false
						end if
					end if
				end try
			end tell
		end timeout
	end try
	
	set Desk_w to Desk_w_
	set Desk_h to Desk_h_
	set Dock_o to Dock_o_
	set Dock_w to Dock_w_
	set Dock_h to Dock_h_
	
	delay loop_delay
	
end repeat

to getDesktopBounds()
	tell application "Finder"
		return bounds of window of desktop
	end tell
end getDesktopBounds

to getDockOrientation()
	tell application "System Events"
		tell process "Dock"
			return orientation in list 1
		end tell
	end tell
end getDockOrientation

to getDockSize()
	tell application "System Events"
		tell process "Dock"
			return size in list 1
		end tell
	end tell
end getDockSize

to getDockPos()
	--unhideDock()
	delay 0.3
	tell application "System Events"
		tell process "Dock"
			set dock_position to position in list 1
		end tell
	end tell
end getDockPos
