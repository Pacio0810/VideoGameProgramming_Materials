.data

.text

addiu $s0, $zero, 0xffff8010 #Move Heading
addiu $s1, $zero, 0xffff8020 #Track as bool 0 or 1
addiu $s2, $zero, 0xffff8030 #CurrentX 
addiu $s3, $zero, 0xffff8040 #CurrentY
addiu $s4, $zero, 0xffff8050 #Move as bool 0 or 1

main_loop:
	
	move_right_loop:
		lw $a1, 0($s2)
		bne $a1, 100 move_right_and_leave_track
		
	addiu $a0, $zero, 0
	sw $a0, 0($s4) #Disable movement
	
	addiu $t0, $zero, 0
	sw $t0, 0($s1) #Disable track
	
	move_down_loop:
		lw $a1, 0($s3)
		bne $a1, 100 move_down_and_leave_track
		
	addiu $a0, $zero, 0
	sw $a0, 0($s4) #Disable movement
	
	addiu $t0, $zero, 0
	sw $t0, 0($s1) #Disable track
	
	move_left_loop:
		lw $a1, 0($s2)
		bne $a1, 0 move_left_and_leave_track
		
	addiu $a0, $zero, 0
	sw $a0, 0($s4) #Disable movement
	
	addiu $t0, $zero, 0
	sw $t0, 0($s1) #Disable track
	
	move_up_loop:
		lw $a1, 0($s3)
		bne $a1, 50 move_up_and_leave_track
		
	addiu $a0, $zero, 0
	sw $a0, 0($s4) #Disable movement
	
	addiu $t0, $zero, 0
	sw $t0, 0($s1) #Disable track
	
	move_right_loop_2:
		lw $a1, 0($s2)
		bne $a1, 50 move_right_and_do_not_leave_track
	
	addiu $a0, $zero, 0
	sw $a0, 0($s4) #Disable movement
		
	j exit
	
move_right_and_leave_track:
	addiu $t0, $zero, 1 
	sw $t0, 0($s1) #Leave track
	
	addiu $t0, $zero, 90 # right direction
	sw $t0, 0($s0) 
	
	addiu $t0, $zero, 1 #Enable movement
	sw $t0, 0($s4) 
	
	j move_right_loop
	
move_down_and_leave_track:
	addiu $t0, $zero, 1 
	sw $t0, 0($s1) #Leave track
	
	addiu $t0, $zero, 180 # down direction
	sw $t0, 0($s0)
	
	addiu $t0, $zero, 1 #Enable movement
	sw $t0, 0($s4) 
	
	j move_down_loop
	
move_left_and_leave_track :
	addiu $t0, $zero, 1 
	sw $t0, 0($s1) #Leave track
	
	addiu $t0, $zero, 270 # down direction
	sw $t0, 0($s0)
	
	addiu $t0, $zero, 1 #Enable movement
	sw $t0, 0($s4)
	
	j move_left_loop
	
move_up_and_leave_track :
	addiu $t0, $zero, 1 
	sw $t0, 0($s1) #Leave track
	
	addiu $t0, $zero, 0 # down direction
	sw $t0, 0($s0)
	
	addiu $t0, $zero, 1 #Enable movement
	sw $t0, 0($s4)
	
	j move_up_loop
	
move_right_and_do_not_leave_track :
	addiu $t0, $zero, 90 # down direction 
	sw $t0, 0($s0)
	
	addiu $t0, $zero, 1 #Enable movement
	sw $t0, 0($s4)
	j move_right_loop_2
exit:	
	

	







