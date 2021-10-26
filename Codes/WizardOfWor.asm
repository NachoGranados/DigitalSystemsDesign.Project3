.data	

	backgroundColor:	.word 0x00000000		
	wallColor:		.word 0x00007bff
	
	# agent identifies which element (player or enemy) the function is handing
	# 0 is the player
	# 1 is the enemy 1
	# 2 is the enemy 2
	# 3 is the enemy 3
	# 4 is the enemy 4
	# 5 is the enemy 5
	# 6 is the enemy 6
	# 7 is the player bullet
	agent:			.word 0
	
	# Player
	playerPosX:		.word 9
	playerPosY:		.word 2
	playerDir: 		.word 3
	playerState:		.word 0x00ffc800
	playerActive:		.word 1
	
	# PlayerBullet
	playerBulletActive: 	.word 0
	playerBulletPosX:	.word 0
	playerBulletPosY:	.word 0
	playerBulletDir:	.word 0
	playerBulletState:	.word 0x00ffffff
	
	# PlayerScore
	playerScoreNumber:	.word 0
	playerScorePosX:	.word 14
	playerScorePosY:	.word 39
	playerScoreState:	.word 0x00ffffff
	
	# Enemy 1
	enemy1PosX:		.word 53
	enemy1PosY:		.word 2
	enemy1Dir: 		.word 2 
	enemy1State:		.word 0x00fc0303 # Red
	enemy1Active:		.word 1
	
	# Enemy 2
	enemy2PosX:		.word 53
	enemy2PosY:		.word 20
	enemy2Dir: 		.word 2
	enemy2State:		.word 0x00ff6f00 # Orange
	enemy2Active:		.word 1
	
	# Enemy 3
	enemy3PosX:		.word 19
	enemy3PosY:		.word 32
	enemy3Dir: 		.word 0
	enemy3State:		.word 0x0011ff00 # Green
	enemy3Active:		.word 1
	
	# Enemy 4
	enemy4PosX:		.word 31
	enemy4PosY:		.word 32
	enemy4Dir: 		.word 0x00000000
	enemy4State:		.word 0x0000e5ff # Light blue
	enemy4Active:		.word 1
	
	# Enemy 5
	enemy5PosX:		.word 43
	enemy5PosY:		.word 32
	enemy5Dir: 		.word 0x00000000
	enemy5State:		.word 0x007700ff # Purple
	enemy5Active:		.word 1
	
	# Enemy 6
	enemy6PosX:		.word 9
	enemy6PosY:		.word 20
	enemy6Dir: 		.word 0x00000003
	enemy6State:		.word 0x00ff00e6 # Pink
	enemy6Active:		.word 1
	
	rounds:			.word 1

.text


NewGame:

	jal ClearBoard

	DrawMenu:					
			
		# W			
		li $a0, 15
		li $a1, 2
		lw $a2, playerState
		li $a3, 7
		jal DrawVerticalLine
		
		li $a0, 16
		li $a1, 8
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 17
		li $a1, 6
		lw $a2, playerState
		li $a3, 7
		jal DrawVerticalLine
		
		li $a0, 18
		li $a1, 8
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 19
		li $a1, 2
		lw $a2, playerState
		li $a3, 7
		jal DrawVerticalLine		
		
		# I		
		li $a0, 21
		li $a1, 2
		lw $a2, playerState
		li $a3, 8
		jal DrawVerticalLine
		
		# Z
		li $a0, 23
		li $a1, 2
		lw $a2, playerState
		li $a3, 27
		jal DrawHorizontalLine
		
		li $a0, 27
		li $a1, 3
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 26
		li $a1, 4
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 25
		li $a1, 5
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 24
		li $a1, 6
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 23
		li $a1, 7
		lw $a2, playerState
		jal DrawPoint
						
		li $a0, 23
		li $a1, 8
		lw $a2, playerState
		li $a3, 27
		jal DrawHorizontalLine
		
		# A
		li $a0, 29
		li $a1, 4
		lw $a2, playerState
		li $a3, 8
		jal DrawVerticalLine	
		
		li $a0, 30
		li $a1, 3
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 31
		li $a1, 2
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 32
		li $a1, 3
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 33
		li $a1, 4
		lw $a2, playerState
		li $a3, 8
		jal DrawVerticalLine
		
		li $a0, 29
		li $a1, 6
		lw $a2, playerState
		li $a3, 33
		jal DrawHorizontalLine
		
		# R
		li $a0, 35
		li $a1, 2
		lw $a2, playerState
		li $a3, 8
		jal DrawVerticalLine
		
		li $a0, 39
		li $a1, 3
		lw $a2, playerState
		li $a3, 4
		jal DrawVerticalLine
		
		li $a0, 35
		li $a1, 2
		lw $a2, playerState
		li $a3, 38
		jal DrawHorizontalLine
		
		li $a0, 35
		li $a1, 5
		lw $a2, playerState
		li $a3, 38
		jal DrawHorizontalLine
		
		li $a0, 37
		li $a1, 6
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 38
		li $a1, 7
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 39
		li $a1, 8
		lw $a2, playerState
		jal DrawPoint
		
		# D
		li $a0, 41
		li $a1, 2
		lw $a2, playerState
		li $a3, 8
		jal DrawVerticalLine
		
		li $a0, 45
		li $a1, 3
		lw $a2, playerState
		li $a3, 7
		jal DrawVerticalLine
		
		li $a0, 41
		li $a1, 2
		lw $a2, playerState
		li $a3, 44
		jal DrawHorizontalLine
		
		li $a0, 41
		li $a1, 8
		lw $a2, playerState
		li $a3, 44
		jal DrawHorizontalLine
		
		# O
		li $a0, 26
		li $a1, 12
		lw $a2, playerState
		li $a3, 16
		jal DrawVerticalLine
		
		li $a0, 30
		li $a1, 12
		lw $a2, playerState
		li $a3, 16
		jal DrawVerticalLine
		
		li $a0, 27
		li $a1, 11
		lw $a2, playerState
		li $a3, 29
		jal DrawHorizontalLine
		
		li $a0, 27
		li $a1, 17
		lw $a2, playerState
		li $a3, 29
		jal DrawHorizontalLine
		
		# F
		li $a0, 32
		li $a1, 11
		lw $a2, playerState
		li $a3, 17
		jal DrawVerticalLine
		
		li $a0, 32
		li $a1, 11
		lw $a2, playerState
		li $a3, 36
		jal DrawHorizontalLine
		
		li $a0, 32
		li $a1, 14
		lw $a2, playerState
		li $a3, 34
		jal DrawHorizontalLine
		
		# W
		li $a0, 23
		li $a1, 20
		lw $a2, playerState
		li $a3, 25
		jal DrawVerticalLine
		
		li $a0, 24
		li $a1, 26
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 25
		li $a1, 24
		lw $a2, playerState
		li $a3, 25
		jal DrawVerticalLine
		
		li $a0, 26
		li $a1, 26
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 27
		li $a1, 20
		lw $a2, playerState
		li $a3, 25
		jal DrawVerticalLine
		
		# O
		li $a0, 29
		li $a1, 21
		lw $a2, playerState
		li $a3, 25
		jal DrawVerticalLine
		
		li $a0, 33
		li $a1, 21
		lw $a2, playerState
		li $a3, 25
		jal DrawVerticalLine
		
		li $a0, 30
		li $a1, 20
		lw $a2, playerState
		li $a3, 32
		jal DrawHorizontalLine
		
		li $a0, 30
		li $a1, 26
		lw $a2, playerState
		li $a3, 32
		jal DrawHorizontalLine			
		
		# R
		li $a0, 35
		li $a1, 20
		lw $a2, playerState
		li $a3, 26
		jal DrawVerticalLine
		
		li $a0, 39
		li $a1, 21
		lw $a2, playerState
		li $a3, 22
		jal DrawVerticalLine
		
		li $a0, 35
		li $a1, 20
		lw $a2, playerState
		li $a3, 38
		jal DrawHorizontalLine
		
		li $a0, 35
		li $a1, 23
		lw $a2, playerState
		li $a3, 38
		jal DrawHorizontalLine
		
		li $a0, 37
		li $a1, 24
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 38
		li $a1, 25
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 39
		li $a1, 26
		lw $a2, playerState
		jal DrawPoint
		
		# Line	
		li $a0, 2
		li $a1, 31
		lw $a2, wallColor
		li $a3, 61
		jal DrawHorizontalLine
		
		li $a0, 1
		li $a1, 32
		lw $a2, wallColor
		li $a3, 62
		jal DrawHorizontalLine
		
		li $a0, 0
		li $a1, 33
		lw $a2, wallColor
		li $a3, 63
		jal DrawHorizontalLine
				
		li $a0, 1
		li $a1, 34
		lw $a2, wallColor
		li $a3, 62
		jal DrawHorizontalLine
		
		li $a0, 2
		li $a1, 35
		lw $a2, wallColor
		li $a3, 61
		jal DrawHorizontalLine
				
		# P
		li $a0, 11
		li $a1, 40
		lw $a2, playerState
		li $a3, 46
		jal DrawVerticalLine
		
		li $a0, 15
		li $a1, 41
		lw $a2, playerState
		li $a3, 42
		jal DrawVerticalLine
		
		li $a0, 11
		li $a1, 40
		lw $a2, playerState
		li $a3, 14
		jal DrawHorizontalLine
		
		li $a0, 11
		li $a1, 43
		lw $a2, playerState
		li $a3, 14
		jal DrawHorizontalLine
		
		# R
		li $a0, 17
		li $a1, 40
		lw $a2, playerState
		li $a3, 46
		jal DrawVerticalLine
		
		li $a0, 21
		li $a1, 41
		lw $a2, playerState
		li $a3, 42
		jal DrawVerticalLine
		
		li $a0, 17
		li $a1, 40
		lw $a2, playerState
		li $a3, 20
		jal DrawHorizontalLine
		
		li $a0, 17
		li $a1, 43
		lw $a2, playerState
		li $a3, 20
		jal DrawHorizontalLine
		
		li $a0, 19
		li $a1, 44
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 20
		li $a1, 45
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 21
		li $a1, 46
		lw $a2, playerState
		jal DrawPoint
		
		# E
		li $a0, 23
		li $a1, 40
		lw $a2, playerState
		li $a3, 27
		jal DrawHorizontalLine	
		
		li $a0, 23
		li $a1, 43
		lw $a2, playerState
		li $a3, 25
		jal DrawHorizontalLine	
		
		li $a0, 23
		li $a1, 46
		lw $a2, playerState
		li $a3, 27
		jal DrawHorizontalLine	
		
		li $a0, 23
		li $a1, 41
		lw $a2, playerState
		li $a3, 46
		jal DrawVerticalLine
		
		# S
		li $a0, 30
		li $a1, 40
		lw $a2, playerState
		li $a3, 32
		jal DrawHorizontalLine	
		
		li $a0, 30
		li $a1, 43
		lw $a2, playerState
		li $a3, 32
		jal DrawHorizontalLine	
		
		li $a0, 30
		li $a1, 46
		lw $a2, playerState
		li $a3, 32
		jal DrawHorizontalLine
		
		li $a0, 29
		li $a1, 41
		lw $a2, playerState
		li $a3, 42
		jal DrawVerticalLine
		
		li $a0, 33
		li $a1, 44
		lw $a2, playerState
		li $a3, 45
		jal DrawVerticalLine
		
		li $a0, 33
		li $a1, 41
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 29
		li $a1, 45
		lw $a2, playerState
		jal DrawPoint
		
		# S
		li $a0, 36
		li $a1, 40
		lw $a2, playerState
		li $a3, 38
		jal DrawHorizontalLine	
		
		li $a0, 36
		li $a1, 43
		lw $a2, playerState
		li $a3, 38
		jal DrawHorizontalLine	
		
		li $a0, 36
		li $a1, 46
		lw $a2, playerState
		li $a3, 38
		jal DrawHorizontalLine
		
		li $a0, 35
		li $a1, 41
		lw $a2, playerState
		li $a3, 42
		jal DrawVerticalLine
		
		li $a0, 39
		li $a1, 44
		lw $a2, playerState
		li $a3, 45
		jal DrawVerticalLine
		
		li $a0, 39
		li $a1, 41
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 35
		li $a1, 45
		lw $a2, playerState
		jal DrawPoint
		
		# 1
		li $a0, 47
		li $a1, 46
		lw $a2, playerState
		li $a3, 51
		jal DrawHorizontalLine
		
		li $a0, 49
		li $a1, 40
		lw $a2, playerState
		li $a3, 46
		jal DrawVerticalLine
		
		li $a0, 48
		li $a1, 41
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 47
		li $a1, 42
		lw $a2, playerState
		jal DrawPoint
		
		# T
		li $a0, 8
		li $a1, 49
		lw $a2, playerState
		li $a3, 12
		jal DrawHorizontalLine
		
		li $a0, 10
		li $a1, 49
		lw $a2, playerState
		li $a3, 55
		jal DrawVerticalLine
		
		# O
		li $a0, 14
		li $a1, 50
		lw $a2, playerState
		li $a3, 54
		jal DrawVerticalLine
		
		li $a0, 18
		li $a1, 50
		lw $a2, playerState
		li $a3, 54
		jal DrawVerticalLine
		
		li $a0, 15
		li $a1, 49
		lw $a2, playerState
		li $a3, 17
		jal DrawHorizontalLine
		
		li $a0, 15
		li $a1, 55
		lw $a2, playerState
		li $a3, 17
		jal DrawHorizontalLine	
		
		# S
		li $a0, 27
		li $a1, 49
		lw $a2, playerState
		li $a3, 29
		jal DrawHorizontalLine	
		
		li $a0, 27
		li $a1, 52
		lw $a2, playerState
		li $a3, 29
		jal DrawHorizontalLine	
		
		li $a0, 27
		li $a1, 55
		lw $a2, playerState
		li $a3, 29
		jal DrawHorizontalLine
		
		li $a0, 26
		li $a1, 50
		lw $a2, playerState
		li $a3, 51
		jal DrawVerticalLine
		
		li $a0, 30
		li $a1, 53
		lw $a2, playerState
		li $a3, 54
		jal DrawVerticalLine
		
		li $a0, 30
		li $a1, 50
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 26
		li $a1, 54
		lw $a2, playerState
		jal DrawPoint
		
		# T
		li $a0, 32
		li $a1, 49
		lw $a2, playerState
		li $a3, 36
		jal DrawHorizontalLine
		
		li $a0, 34
		li $a1, 49
		lw $a2, playerState
		li $a3, 55
		jal DrawVerticalLine
		
		# A
		li $a0, 38
		li $a1, 51
		lw $a2, playerState
		li $a3, 55
		jal DrawVerticalLine	
		
		li $a0, 39
		li $a1, 50
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 40
		li $a1, 49
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 41
		li $a1, 50
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 42
		li $a1, 51
		lw $a2, playerState
		li $a3, 55
		jal DrawVerticalLine
		
		li $a0, 38
		li $a1, 53
		lw $a2, playerState
		li $a3, 42
		jal DrawHorizontalLine
		
		# R
		li $a0, 44
		li $a1, 49
		lw $a2, playerState
		li $a3, 55
		jal DrawVerticalLine
		
		li $a0, 48
		li $a1, 50
		lw $a2, playerState
		li $a3, 51
		jal DrawVerticalLine
		
		li $a0, 44
		li $a1, 49
		lw $a2, playerState
		li $a3, 47
		jal DrawHorizontalLine
		
		li $a0, 44
		li $a1, 52
		lw $a2, playerState
		li $a3, 47
		jal DrawHorizontalLine
		
		li $a0, 46
		li $a1, 53
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 47
		li $a1, 54
		lw $a2, playerState
		jal DrawPoint
		
		li $a0, 48
		li $a1, 55
		lw $a2, playerState
		jal DrawPoint
		
		# T
		li $a0, 50
		li $a1, 49
		lw $a2, playerState
		li $a3, 54
		jal DrawHorizontalLine
		
		li $a0, 52
		li $a1, 49
		lw $a2, playerState
		li $a3, 55
		jal DrawVerticalLine
		
		
SelectMode:

	lw $t1, 0xFFFF0004 # check to see which key has been pressed
	beq $t1, 0x00000031, BeginGame # 1 pressed
			
	li $a0, 75	#
	li $v0, 32	# pause for 75 milisec
	syscall		#
		
	j SelectMode    # Jump back to the top of the wait loop
	
	
BeginGame:
	
	sw $zero, 0xFFFF0000
	
	jal ClearBoard
	
	# Draw player						
	lw $a0, playerPosX
	lw $a1, playerPosY
	lw $a2, playerState
	lw $a3, playerDir
	
	jal DrawAgent
	
	# Draw enemy1			
	lw $a0, enemy1PosX
	lw $a1, enemy1PosY
	lw $a2, enemy1State
	lw $a3, enemy1Dir
	
	jal DrawAgent
	
	# Draw enemy2			
	lw $a0, enemy2PosX
	lw $a1, enemy2PosY
	lw $a2, enemy2State
	lw $a3, enemy2Dir
	
	jal DrawAgent
	
	# Draw enemy3		
	lw $a0, enemy3PosX
	lw $a1, enemy3PosY
	lw $a2, enemy3State
	lw $a3, enemy3Dir
	
	jal DrawAgent
	
	# Draw enemy4			
	lw $a0, enemy4PosX
	lw $a1, enemy4PosY
	lw $a2, enemy4State
	lw $a3, enemy4Dir
	
	jal DrawAgent
	
	# Draw enemy5		
	lw $a0, enemy5PosX
	lw $a1, enemy5PosY
	lw $a2, enemy5State
	lw $a3, enemy5Dir
	
	jal DrawAgent
	
	# Draw enemy6
	lw $a0, enemy6PosX
	lw $a1, enemy6PosY
	lw $a2, enemy6State
	lw $a3, enemy6Dir
	
	jal DrawAgent
			
	
DrawMap:

	# Horizantal lines
	
	# First level		
	li $a0, 7
	li $a1, 0
	lw $a2, wallColor
	li $a3, 57
	jal DrawHorizontalLine
	
	# Second level
	li $a0, 20
	li $a1, 6
	lw $a2, wallColor
	li $a3, 24
	jal DrawHorizontalLine
	
	li $a0, 30
	li $a1, 6
	lw $a2, wallColor
	li $a3, 34
	jal DrawHorizontalLine
	
	li $a0, 40
	li $a1, 6
	lw $a2, wallColor
	li $a3, 44
	jal DrawHorizontalLine
	
	# Third level
	li $a0, 0
	li $a1, 12
	lw $a2, wallColor
	li $a3, 7
	jal DrawHorizontalLine
	
	li $a0, 25
	li $a1, 12
	lw $a2, wallColor
	li $a3, 29
	jal DrawHorizontalLine
	
	li $a0, 35
	li $a1, 12
	lw $a2, wallColor
	li $a3, 39
	jal DrawHorizontalLine
	
	li $a0, 57
	li $a1, 12
	lw $a2, wallColor
	li $a3, 63
	jal DrawHorizontalLine
	
	# Fourth level
	li $a0, 0
	li $a1, 18
	lw $a2, wallColor
	li $a3, 13
	jal DrawHorizontalLine
	
	li $a0, 20
	li $a1, 18
	lw $a2, wallColor
	li $a3, 24
	jal DrawHorizontalLine
	
	li $a0, 30
	li $a1, 18
	lw $a2, wallColor
	li $a3, 34
	jal DrawHorizontalLine
		
	li $a0, 40
	li $a1, 18
	lw $a2, wallColor
	li $a3, 44
	jal DrawHorizontalLine
	
	li $a0, 51
	li $a1, 18
	lw $a2, wallColor
	li $a3, 63
	jal DrawHorizontalLine
	
	# Fiveth level
	li $a0, 19
	li $a1, 24
	lw $a2, wallColor
	li $a3, 29
	jal DrawHorizontalLine
	
	li $a0, 35
	li $a1, 24
	lw $a2, wallColor
	li $a3, 45
	jal DrawHorizontalLine
		
	# Sixth level
	li $a0, 13
	li $a1, 30
	lw $a2, wallColor
	li $a3, 17
	jal DrawHorizontalLine
	
	li $a0, 47
	li $a1, 30
	lw $a2, wallColor
	li $a3, 50
	jal DrawHorizontalLine
		
	# Seventh level
	li $a0, 7
	li $a1, 36
	lw $a2, wallColor
	li $a3, 57
	jal DrawHorizontalLine
	
	# Vertical lines
	
	# First level	
	li $a0, 7
	li $a1, 0
	lw $a2, wallColor
	li $a3, 12
	jal DrawVerticalLine
		
	li $a0, 57
	li $a1, 0
	lw $a2, wallColor
	li $a3, 12
	jal DrawVerticalLine
	
	# Second level
	li $a0, 13
	li $a1, 6
	lw $a2, wallColor
	li $a3, 12
	jal DrawVerticalLine
		
	li $a0, 19
	li $a1, 6
	lw $a2, wallColor
	li $a3, 18
	jal DrawVerticalLine
	
	li $a0, 45
	li $a1, 6
	lw $a2, wallColor
	li $a3, 18
	jal DrawVerticalLine
	
	li $a0, 51
	li $a1, 6
	lw $a2, wallColor
	li $a3, 12
	jal DrawVerticalLine
	
	# Third level
	li $a0, 7
	li $a1, 18
	lw $a2, wallColor
	li $a3, 36
	jal DrawVerticalLine
		
	li $a0, 57
	li $a1, 18
	lw $a2, wallColor
	li $a3, 36
	jal DrawVerticalLine
								
	# Fourth level	
	li $a0, 13
	li $a1, 24
	lw $a2, wallColor
	li $a3, 30
	jal DrawVerticalLine
		
	li $a0, 29
	li $a1, 24
	lw $a2, wallColor
	li $a3, 30
	jal DrawVerticalLine
	
	li $a0, 35
	li $a1, 24
	lw $a2, wallColor
	li $a3, 30
	jal DrawVerticalLine
	
	li $a0, 51
	li $a1, 24
	lw $a2, wallColor
	li $a3, 30
	jal DrawVerticalLine
	
	# Fiveth level	
	li $a0, 23
	li $a1, 30
	lw $a2, wallColor
	li $a3, 36
	jal DrawVerticalLine	
	
	li $a0, 41
	li $a1, 30
	lw $a2, wallColor
	li $a3, 36
	jal DrawVerticalLine
	
	
DrawRadar:

	# Horizontal lines

	# First level
	li $a0, 19
	li $a1, 42
	lw $a2, wallColor
	li $a3, 45
	jal DrawHorizontalLine
	
	# Second level
	li $a0, 19
	li $a1, 61
	lw $a2, wallColor
	li $a3, 45
	jal DrawHorizontalLine
	
	# Vertical lines
	li $a0, 19
	li $a1, 42
	lw $a2, wallColor
	li $a3, 61
	jal DrawVerticalLine
	
	li $a0, 45
	li $a1, 42
	lw $a2, wallColor
	li $a3, 61
	jal DrawVerticalLine
	
	
# Timer counters for bullets movement
li $s3, 0
li $s4, 15

# Timer counters for enemies movement
li $s5, 0
li $s6, 250

										
# Wait and read buttons
Begin_standby:	

	li $t0, 0x00000002 # load 25 into the counter for a ~50 milisec standby
			
Standby:

	blez $t0, EndStandby
	li $a0, 1	#
	li $v0, 32	# pause for 1 milisec
	syscall		#
		
	addi $t0, $t0, -1 		# decrement counter
	
	addi $s3, $s3, 1                # increment bullets counter
	addi $s5, $s5, 1		# increment enemies counter
	
	BulletsMovement:
	
		bne $s3, $s4, EnemiesMovement
		
		li $s3, 0
		
		jal MoveBullets
		
	EnemiesMovement:
		
		bne $s5, $s6, CheckWinGame
	
		li $s5, 0
				
		MoveEnemy1:
		
			lw $t0, enemy1Active
		
			bne $t0, 1, MoveEnemy2 
		
			li $a0, 1
			lw $a1, enemy1Dir
		
			jal MoveAgent
	
		MoveEnemy2:
		
			lw $t0, enemy2Active
		
			bne $t0, 1, MoveEnemy3
			
			li $a0, 2
			lw $a1, enemy2Dir
		
			jal MoveAgent
	
		MoveEnemy3:
		
			lw $t0, enemy3Active
		
			bne $t0, 1, MoveEnemy4
			
			li $a0, 3
			lw $a1, enemy3Dir
		
			jal MoveAgent
	
		MoveEnemy4:
		
			lw $t0, enemy4Active
		
			bne $t0, 1, MoveEnemy5
			
			li $a0, 4
			lw $a1, enemy4Dir
		
			jal MoveAgent
	
		MoveEnemy5:
		
			lw $t0, enemy5Active
		
			bne $t0, 1, MoveEnemy6 
			
			li $a0, 5
			lw $a1, enemy5Dir
		
			jal MoveAgent
	
		MoveEnemy6:
		
			lw $t0, enemy6Active
		
			bne $t0, 1, CheckWinGame 
			
			li $a0, 6
			lw $a1, enemy6Dir
		
			jal MoveAgent
			
	CheckWinGame:
	
		lw $t0, rounds
		
		bne $t0, 4, CheckNewRound
		
		j EndGame
			
	CheckNewRound:
		
		lw $t0, playerScoreNumber
		
		bne $t0, 6, CheckEndGame
		
		li $t0, 0		
		sw $t0, playerScoreNumber
		
		lw $t0, rounds	
		addi $t0, $t0, 1		
		sw $t0, rounds
		
		li $s3, 0		
		li $s5, 0
		
		lw $a0, playerPosX		
		lw $a1, playerPosY
		
		jal EraseCompleteAgent
		
		j NewRound
								
	CheckEndGame:
	
		lw $t0, playerActive
		
		bne $t0, 0, Continue
		
		j EndGame
		
	Continue:
	
		lw $t1, 0xFFFF0000		# check to see if a key has been pressed
		blez $t1, Standby
				
		jal KeyPressed			# see what was pushed
		
		sw $zero, 0xFFFF0000		# clear the button pushed bit
		
		j Standby
				
EndStandby:
	
	j Begin_standby
	
		
# KeyPressed changes the player direction registers depending on the key pressed
KeyPressed:

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	lw $a0, 0xFFFF0004
	
	MoveUp:
	
		bne $a0, 119, MoveDown # W
		
		li $a0, 0
		li $a1, 0
		
		jal MoveAgent
				
		j KeyDone
		
	MoveDown:
	
		bne $a0, 115, MoveLeft # S
		
		li $a0, 0
		li $a1, 1
		
		jal MoveAgent
				
		j KeyDone
	
	MoveLeft:
	
		bne $a0, 97, MoveRight # A
		
		li $a0, 0
		li $a1, 2
		
		jal MoveAgent
				
		j KeyDone

	MoveRight:
	
		bne $a0, 100, Shoot # D
		
		li $a0, 0
		li $a1, 3
		
		jal MoveAgent
				
		j KeyDone	
		
	Shoot:
	
		bne $a0, 32, KeyNone # Space
		
		li $t0, 1
		sw $t0, playerBulletActive
		
		lw $t0, playerDir
		sw $t0, playerBulletDir
		
		BulletUpDir:
		
			bne $t0, 0, BulletDownDir
		
			lw $t1, playerPosX
			addi $t1, $t1, 1
			sw $t1, playerBulletPosX
			move $a0, $t1
			
			lw $t1, playerPosY
			addi $t1, $t1, -1
			sw $t1, playerBulletPosY
			move $a1, $t1
			
			lw $a2, playerBulletState
						
			jal DrawPoint
		
			j KeyDone		
		
		BulletDownDir:
		
			bne $t0, 1, BulletLeftDir
		
			lw $t1, playerPosX
			addi $t1, $t1, 1
			sw $t1, playerBulletPosX
			move $a0, $t1
			
			lw $t1, playerPosY
			addi $t1, $t1, 3
			sw $t1, playerBulletPosY
			move $a1, $t1
			
			lw $a2, playerBulletState
						
			jal DrawPoint
		
			j KeyDone		
		
		BulletLeftDir:
		
			bne $t0, 2, BulletRightDir
		
			lw $t1, playerPosX
			addi $t1, $t1, -1
			sw $t1, playerBulletPosX
			move $a0, $t1
			
			lw $t1, playerPosY
			addi $t1, $t1, 1
			sw $t1, playerBulletPosY
			move $a1, $t1
			
			lw $a2, playerBulletState
						
			jal DrawPoint
		
			j KeyDone	
					
		BulletRightDir:
		
			bne $t0, 3, KeyDone 
		
			lw $t1, playerPosX
			addi $t1, $t1, 3
			sw $t1, playerBulletPosX
			move $a0, $t1
			
			lw $t1, playerPosY
			addi $t1, $t1, 1
			sw $t1, playerBulletPosY
			move $a1, $t1
			
			lw $a2, playerBulletState
						
			jal DrawPoint
		
			j KeyDone			
		
	KeyNone:
	
		# Do nothing
		
	KeyDone:
			
		lw $ra, 0($sp)
		addi $sp, $sp, -4
	
		jr $ra
		
		
MoveBullets:

	addi $sp, $sp, -4
	sw $ra, 0($sp)

	MovePlayerBullets:
		
		lw $s0, playerBulletActive
		
		bne $s0, 1, MoveEnemyBullet
		
		lw $s0, playerBulletDir
		
		MovePlayerBulletsUp:
		
			bne $s0, 0, MovePlayerBulletsDown
			
			lw $s1, playerBulletPosX
			lw $s2, playerBulletPosY
			
			move $a0, $s1
			move $a1, $s2
			lw $a2, backgroundColor
			
			jal DrawPoint
							
			addi $s2, $s2, -1
			sw $s2, playerBulletPosY	
						
			CheckWallCollUp:
			
				move $a0, $s1
				move $a1, $s2
			
				jal LoadColor
			
				lw $t0, wallColor
				
				bne $v0, $t0, CheckEnemyColUp
			
				move $a0, $s1
				move $a1, $s2
				lw $a2, wallColor
				
				jal DrawPoint
				
				li $t0, 0
				sw $t0, playerBulletActive
				
				j MoveBulletDone			
			
			CheckEnemyColUp:
			
				CheckEnemy1ColUp: # red
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy1State
				
					bne $v0, $t0, CheckEnemy2ColUp
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy1Active
					
					lw $a0, enemy1PosX
					lw $a1, enemy1PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy1PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy1PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor			
			
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
			
				CheckEnemy2ColUp: # orange
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy2State
				
					bne $v0, $t0, CheckEnemy3ColUp
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy2Active
					
					lw $a0, enemy2PosX
					lw $a1, enemy2PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy2PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy2PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy3ColUp: # green
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy3State
				
					bne $v0, $t0, CheckEnemy4ColUp
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy3Active
					
					lw $a0, enemy3PosX
					lw $a1, enemy3PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy3PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy3PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy4ColUp: # light blue
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy4State
				
					bne $v0, $t0, CheckEnemy5ColUp
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy4Active
					
					lw $a0, enemy4PosX
					lw $a1, enemy4PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy4PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy4PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy5ColUp: # purple
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy5State
				
					bne $v0, $t0, CheckEnemy6ColUp
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy5Active
					
					lw $a0, enemy5PosX
					lw $a1, enemy5PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy5PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy5PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy6ColUp: # pink
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy6State
				
					bne $v0, $t0, BulletUp
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy6Active
					
					lw $a0, enemy6PosX
					lw $a1, enemy6PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy6PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy6PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
			
			BulletUp:
			
				move $a0, $s1
				move $a1, $s2
				lw $a2, playerBulletState
				
				jal DrawPoint
				
				j MoveBulletDone			
			
		MovePlayerBulletsDown:
		
			bne $s0, 1, MovePlayerBulletsLeft
			
			lw $s1, playerBulletPosX
			lw $s2, playerBulletPosY
			
			move $a0, $s1
			move $a1, $s2
			lw $a2, backgroundColor
			
			jal DrawPoint
							
			addi $s2, $s2, 1
			sw $s2, playerBulletPosY	
						
			CheckWallCollDown:
			
				move $a0, $s1
				move $a1, $s2
			
				jal LoadColor
			
				lw $t0, wallColor
				
				bne $v0, $t0, CheckEnemyColDown
			
				move $a0, $s1
				move $a1, $s2
				lw $a2, wallColor
				
				jal DrawPoint
				
				li $t0, 0
				sw $t0, playerBulletActive
				
				j MoveBulletDone			
			
			CheckEnemyColDown:
			
				CheckEnemy1ColDown: # red
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy1State
				
					bne $v0, $t0, CheckEnemy2ColDown
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy1Active
					
					lw $a0, enemy1PosX
					lw $a1, enemy1PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy1PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy1PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
			
				CheckEnemy2ColDown: # orange
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy2State
				
					bne $v0, $t0, CheckEnemy3ColDown
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy2Active
					
					lw $a0, enemy2PosX
					lw $a1, enemy2PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy2PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy2PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy3ColDown: # green
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy3State
				
					bne $v0, $t0, CheckEnemy4ColDown
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy3Active
					
					lw $a0, enemy3PosX
					lw $a1, enemy3PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy3PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy3PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy4ColDown: # light blue
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy4State
				
					bne $v0, $t0, CheckEnemy5ColDown
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy4Active
					
					lw $a0, enemy4PosX
					lw $a1, enemy4PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy4PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy4PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy5ColDown: # purple
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy5State
				
					bne $v0, $t0, CheckEnemy6ColDown
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy5Active
					
					lw $a0, enemy5PosX
					lw $a1, enemy5PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy5PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy5PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy6ColDown: # pink
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy6State
				
					bne $v0, $t0, BulletDown
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy6Active
					
					lw $a0, enemy6PosX
					lw $a1, enemy6PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy6PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy6PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
			
			BulletDown:
			
				move $a0, $s1
				move $a1, $s2
				lw $a2, playerBulletState
				
				jal DrawPoint
				
				j MoveBulletDone
						
		MovePlayerBulletsLeft:
		
			bne $s0, 2, MovePlayerBulletsRight
			
			lw $s1, playerBulletPosX
			lw $s2, playerBulletPosY
			
			move $a0, $s1
			move $a1, $s2
			lw $a2, backgroundColor
			
			jal DrawPoint
							
			addi $s1, $s1, -1
			sw $s1, playerBulletPosX
						
			CheckWallCollLeft:
			
				move $a0, $s1
				move $a1, $s2
			
				jal LoadColor
			
				lw $t0, wallColor
				
				bne $v0, $t0, CheckEnemyColLeft
			
				move $a0, $s1
				move $a1, $s2
				lw $a2, wallColor
				
				jal DrawPoint
				
				li $t0, 0
				sw $t0, playerBulletActive
				
				j MoveBulletDone			
			
			CheckEnemyColLeft:
			
				CheckEnemy1ColLeft: # red
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy1State
				
					bne $v0, $t0, CheckEnemy2ColLeft
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy1Active
					
					lw $a0, enemy1PosX
					lw $a1, enemy1PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy1PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy1PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
			
				CheckEnemy2ColLeft: # orange
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy2State
				
					bne $v0, $t0, CheckEnemy3ColLeft
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy2Active
					
					lw $a0, enemy2PosX
					lw $a1, enemy2PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy2PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy2PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy3ColLeft: # green
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy3State
				
					bne $v0, $t0, CheckEnemy4ColLeft
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy3Active
					
					lw $a0, enemy3PosX
					lw $a1, enemy3PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy3PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy3PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy4ColLeft: # light blue
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy4State
				
					bne $v0, $t0, CheckEnemy5ColLeft
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy4Active
					
					lw $a0, enemy4PosX
					lw $a1, enemy4PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy4PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy4PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy5ColLeft: # purple
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy5State
				
					bne $v0, $t0, CheckEnemy6ColLeft
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy5Active
					
					lw $a0, enemy5PosX
					lw $a1, enemy5PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy5PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy5PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy6ColLeft: # pink
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy6State
				
					bne $v0, $t0, BulletLeft
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy6Active
					
					lw $a0, enemy6PosX
					lw $a1, enemy6PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy6PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy6PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
			
			BulletLeft:
			
				move $a0, $s1
				move $a1, $s2
				lw $a2, playerBulletState
				
				jal DrawPoint
				
				j MoveBulletDone			
			
		MovePlayerBulletsRight:
		
			bne $s0, 3, MoveBulletDone
			
			lw $s1, playerBulletPosX
			lw $s2, playerBulletPosY
			
			move $a0, $s1
			move $a1, $s2
			lw $a2, backgroundColor
			
			jal DrawPoint
							
			addi $s1, $s1, 1
			sw $s1, playerBulletPosX
						
			CheckWallCollRight:
			
				move $a0, $s1
				move $a1, $s2
			
				jal LoadColor
			
				lw $t0, wallColor
				
				bne $v0, $t0, CheckEnemyColRight
			
				move $a0, $s1
				move $a1, $s2
				lw $a2, wallColor
				
				jal DrawPoint
				
				li $t0, 0
				sw $t0, playerBulletActive
				
				j MoveBulletDone			
			
			CheckEnemyColRight:
			
				CheckEnemy1ColRight: # red
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy1State
				
					bne $v0, $t0, CheckEnemy2ColRight
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy1Active
					
					lw $a0, enemy1PosX
					lw $a1, enemy1PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy1PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy1PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
			
				CheckEnemy2ColRight: # orange
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy2State
				
					bne $v0, $t0, CheckEnemy3ColRight
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy2Active
					
					lw $a0, enemy2PosX
					lw $a1, enemy2PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy2PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy2PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy3ColRight: # green
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy3State
				
					bne $v0, $t0, CheckEnemy4ColRight
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy3Active
					
					lw $a0, enemy3PosX
					lw $a1, enemy3PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy3PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy3PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy4ColRight: # light blue
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy4State
				
					bne $v0, $t0, CheckEnemy5ColRight
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy4Active
					
					lw $a0, enemy4PosX
					lw $a1, enemy4PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy4PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy4PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy5ColRight: # purple
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy5State
				
					bne $v0, $t0, CheckEnemy6ColRight
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy5Active
					
					lw $a0, enemy5PosX
					lw $a1, enemy5PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy5PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy5PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
				
				CheckEnemy6ColRight: # pink
					
					move $a0, $s1
					move $a1, $s2
			
					jal LoadColor
			
					lw $t0, enemy6State
				
					bne $v0, $t0, BulletRight
			
					move $a0, $s1
					move $a1, $s2
					lw $a2, backgroundColor
				
					jal DrawPoint
				
					li $t0, 0
					sw $t0, playerBulletActive
					
					li $t0, 0
					sw $t0, enemy6Active
					
					lw $a0, enemy6PosX
					lw $a1, enemy6PosY
					
					jal EraseCompleteAgent
					
					lw $a0, enemy6PosX
					srl $a0, $a0, 1
					addi $a0, $a0, 17			
					lw $a1, enemy6PosY
					srl $a1, $a1, 1
					addi $a1, $a1, 43
					lw $a2, backgroundColor	
					
					jal DrawPoint
					
					lw $a0, playerScorePosX
					lw $a1, playerScorePosY
					lw $a2, playerScoreState
					
					jal DrawPoint
					
					lw $t0, playerScoreNumber
					addi $t0, $t0, 1
					sw $t0, playerScoreNumber
					
					lw $t0, playerScorePosX
					addi $t0, $t0, 2
					sw $t0, playerScorePosX
					
					j MoveBulletDone
			
			BulletRight:
			
				move $a0, $s1
				move $a1, $s2
				lw $a2, playerBulletState
				
				jal DrawPoint
				
				j MoveBulletDone
			
	MoveEnemyBullet:	
			
	MoveBulletDone:
	
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		jr $ra
									
				
# MoveAgent will change the direction of the player an then try to move in the given direction		
# $a0 is the agent
# $a1 is the new direction
MoveAgent:

	addi $sp, $sp, -12
	sw $ra , 0($sp)
	sw $a0 , 4($sp)
	sw $a1 , 8($sp)

	MoveAgentPlayer:
	
		bne $a0, 0, MoveAgentEnemy1
		
		lw $t1, playerDir
		
		beq $a1, $t1, AdvanceBlockPlayer
		
		lw $a0, playerPosX
		lw $a1, playerPosY
		lw $a2, playerDir
		
		jal EraseAgent
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
				
		move $a3, $a1
				
		sw $a3, playerDir # store in memory the new direction						
		lw $a0, playerPosX
		lw $a1, playerPosY
		lw $a2, playerState
		
		jal DrawAgent # draw the player in the new direction
		
		AdvanceBlockPlayer:
		
			j MoveAgentDone
		
	MoveAgentEnemy1:
	
		bne $a0, 1, MoveAgentEnemy2
				
		lw $t1, enemy1Dir
		
		beq $a1, $t1, AdvanceBlockEnemy1
		
		lw $a0, enemy1PosX
		lw $a1, enemy1PosY
		lw $a2, enemy1Dir
		
		jal EraseAgent
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
				
		move $a3, $a1
				
		sw $a3, enemy1Dir # store in memory the new direction						
		lw $a0, enemy1PosX
		lw $a1, enemy1PosY
		lw $a2, enemy1State
		
		jal DrawAgent # draw the player in the new direction
		
		AdvanceBlockEnemy1:
		
			j MoveAgentDone
				
							
	MoveAgentEnemy2:
	
		bne $a0, 2, MoveAgentEnemy3
		
		lw $t1, enemy2Dir
		
		beq $a1, $t1, AdvanceBlockEnemy2
		
		lw $a0, enemy2PosX
		lw $a1, enemy2PosY
		lw $a2, enemy2Dir
		
		jal EraseAgent
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
				
		move $a3, $a1
				
		sw $a3, enemy2Dir # store in memory the new direction						
		lw $a0, enemy2PosX
		lw $a1, enemy2PosY
		lw $a2, enemy2State
		
		jal DrawAgent # draw the player in the new direction
		
		AdvanceBlockEnemy2:
		
			j MoveAgentDone
		
	MoveAgentEnemy3:
	
		bne $a0, 3, MoveAgentEnemy4
		
		lw $t1, enemy3Dir
		
		beq $a1, $t1, AdvanceBlockEnemy3
		
		lw $a0, enemy3PosX
		lw $a1, enemy3PosY
		lw $a2, enemy3Dir
		
		jal EraseAgent
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
				
		move $a3, $a1
				
		sw $a3, enemy3Dir # store in memory the new direction						
		lw $a0, enemy3PosX
		lw $a1, enemy3PosY
		lw $a2, enemy3State
		
		jal DrawAgent # draw the player in the new direction
		
		AdvanceBlockEnemy3:
		
			j MoveAgentDone
		
	MoveAgentEnemy4:
	
		bne $a0, 4, MoveAgentEnemy5
		
		lw $t1, enemy4Dir
		
		beq $a1, $t1, AdvanceBlockEnemy4
		
		lw $a0, enemy4PosX
		lw $a1, enemy4PosY
		lw $a2, enemy4Dir
		
		jal EraseAgent
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
				
		move $a3, $a1
				
		sw $a3, enemy4Dir # store in memory the new direction						
		lw $a0, enemy4PosX
		lw $a1, enemy4PosY
		lw $a2, enemy4State
		
		jal DrawAgent # draw the player in the new direction
		
		AdvanceBlockEnemy4:
		
			j MoveAgentDone
		
	MoveAgentEnemy5:
	
		bne $a0, 5, MoveAgentEnemy6
		
		lw $t1, enemy5Dir
		
		beq $a1, $t1, AdvanceBlockEnemy5
		
		lw $a0, enemy5PosX
		lw $a1, enemy5PosY
		lw $a2, enemy5Dir
		
		jal EraseAgent
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
				
		move $a3, $a1
				
		sw $a3, enemy5Dir # store in memory the new direction						
		lw $a0, enemy5PosX
		lw $a1, enemy5PosY
		lw $a2, enemy5State
		
		jal DrawAgent # draw the player in the new direction
		
		AdvanceBlockEnemy5:
		
			j MoveAgentDone
		
	MoveAgentEnemy6:
	
		bne $a0, 6, MoveAgentDone
		
		lw $t1, enemy6Dir
		
		beq $a1, $t1, AdvanceBlockEnemy6
		
		lw $a0, enemy6PosX
		lw $a1, enemy6PosY
		lw $a2, enemy6Dir
		
		jal EraseAgent
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
				
		move $a3, $a1
				
		sw $a3, enemy6Dir # store in memory the new direction						
		lw $a0, enemy6PosX
		lw $a1, enemy6PosY
		lw $a2, enemy6State
		
		jal DrawAgent # draw the player in the new direction
		
		AdvanceBlockEnemy6:
		
			j MoveAgentDone
		
	MoveAgentDone:
	
		lw $ra, 0($sp)
		addi $sp, $sp, 12
	
			
# If it is possible, the agent agent will try to move forward with a given direction
# $a0 agent
TryMoveAgent:

	addi, $sp, $sp, -4
	sw $ra, 0($sp)
	
	TryMoveAgentPlayer:
	
		bne $a0, 0, TryMoveAgentEnemy1
		
		lw $t0, playerDir
		
		PlayerMoveUp:
		
			bne $t0, 0, PlayerMoveDown
			
			lw $a0, playerPosX
			lw $a1, playerPosY
			lw $a2, playerDir
			
			jal EraseAgent
			
			# Make the test to see if there is collision
			li $a0, 0 # the player
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision						
			
			bne $v0, 0, DrawPlayerPositionUp			
			
			lw $t1, playerPosY
			addi $t1, $t1, -1
			sw $t1, playerPosY
			
			DrawPlayerPositionUp:
			
				lw $a0, playerPosX
				lw $a1, playerPosY
				lw $a2, playerState
				lw $a3, playerDir
			
				jal DrawAgent
			
			j TryMoveAgentDone
			
		PlayerMoveDown:
		
			bne $t0, 1, PlayerMoveLeft
			
			lw $a0, playerPosX
			lw $a1, playerPosY
			lw $a2, playerDir
			
			jal EraseAgent
			
			# Make the test to see if there is collision
			li $a0, 0 # the player
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, DrawPlayerPositionDown
			
			lw $t1, playerPosY
			addi $t1, $t1, 1
			sw $t1, playerPosY
								
			DrawPlayerPositionDown:
			
				lw $a0, playerPosX
				lw $a1, playerPosY
				lw $a2, playerState
				lw $a3, playerDir
			
				jal DrawAgent
			
			j TryMoveAgentDone
			
		PlayerMoveLeft:
		
			bne $t0, 2, PlayerMoveRight
			
			lw $a0, playerPosX
			lw $a1, playerPosY
			lw $a2, playerDir
			
			jal EraseAgent
				
			# Make the test to see if there is collision
			li $a0, 0 # the player
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, DrawPlayerPositionLeft
			
			lw $t1, playerPosX
			addi $t1, $t1, -1
			sw $t1, playerPosX
			
			DrawPlayerPositionLeft:
			
				lw $a0, playerPosX
				lw $a1, playerPosY
				lw $a2, playerState
				lw $a3, playerDir
			
				jal DrawAgent
			
			j TryMoveAgentDone
			
		PlayerMoveRight:
		
			bne $t0, 3, TryMoveAgentDone
		
			lw $a0, playerPosX
			lw $a1, playerPosY
			lw $a2, playerDir
			
			jal EraseAgent
			
			# Make the test to see if there is collision
			li $a0, 0 # the player
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, DrawPlayerPositionRight
			
			lw $t1, playerPosX
			addi $t1, $t1, 1
			sw $t1, playerPosX
						
			DrawPlayerPositionRight:
			
				lw $a0, playerPosX
				lw $a1, playerPosY
				lw $a2, playerState
				lw $a3, playerDir
			
				jal DrawAgent
			
			j TryMoveAgentDone
		
	TryMoveAgentEnemy1:
	
		bne $a0, 1, TryMoveAgentEnemy2
		
		lw $t0, enemy1Dir
		
		Enemy1MoveUp:
		
			bne $t0, 0, Enemy1MoveDown
			
			lw $a0, enemy1PosX
			lw $a1, enemy1PosY
			lw $a2, enemy1Dir
			
			jal EraseAgent
			
			lw $a0, enemy1PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy1PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 1 # the enemy 1
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy1DirUp		
			
			lw $t1, enemy1PosY
			addi $t1, $t1, -1
			sw $t1, enemy1PosY		
									
			lw $a0, enemy1PosX
			lw $a1, enemy1PosY
			lw $a2, enemy1State
			lw $a3, enemy1Dir
			
			jal DrawAgent
			
			lw $a0, enemy1PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy1PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy1State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy1DirUp:
			
				li $t2, 2
				sw $t2, enemy1Dir # store in memory the new direction
				
				lw $a0, enemy1PosX
				lw $a1, enemy1PosY
				lw $a2, enemy1State
				lw $a3, enemy1Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy1
						
		Enemy1MoveDown:
		
			bne $t0, 1, Enemy1MoveLeft
			
			lw $a0, enemy1PosX
			lw $a1, enemy1PosY
			lw $a2, enemy1Dir
			
			jal EraseAgent
			
			lw $a0, enemy1PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy1PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 1 # the enemy 1
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy1DirDown
			
			lw $t1, enemy1PosY
			addi $t1, $t1, 1
			sw $t1, enemy1PosY
								
			lw $a0, enemy1PosX
			lw $a1, enemy1PosY
			lw $a2, enemy1State
			lw $a3, enemy1Dir
		
			jal DrawAgent
			
			lw $a0, enemy1PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy1PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy1State			
			
			jal DrawPoint
		
			j TryMoveAgentDone
				
			ChangeEnemy1DirDown:
			
				li $t2, 0
				sw $t2, enemy1Dir # store in memory the new direction
				
				lw $a0, enemy1PosX
				lw $a1, enemy1PosY
				lw $a2, enemy1State
				lw $a3, enemy1Dir
			
				jal DrawAgent
										
				j TryMoveAgentEnemy1
			
		Enemy1MoveLeft:
		
			bne $t0, 2, Enemy1MoveRight
			
			lw $a0, enemy1PosX
			lw $a1, enemy1PosY
			lw $a2, enemy1Dir
			
			jal EraseAgent
			
			lw $a0, enemy1PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy1PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
				
			# Make the test to see if there is collision
			li $a0, 1 # the enemy 1
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy1DirLeft
			
			lw $t1, enemy1PosX
			addi $t1, $t1, -1
			sw $t1, enemy1PosX
						
			lw $a0, enemy1PosX
			lw $a1, enemy1PosY
			lw $a2, enemy1State
			lw $a3, enemy1Dir
			
			jal DrawAgent
			
			lw $a0, enemy1PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy1PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy1State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy1DirLeft:
			
				li $t2, 3
				sw $t2, enemy1Dir # store in memory the new direction
				
				lw $a0, enemy1PosX
				lw $a1, enemy1PosY
				lw $a2, enemy1State
				lw $a3, enemy1Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy1
			
		Enemy1MoveRight:
		
			bne $t0, 3, TryMoveAgentDone
		
			lw $a0, enemy1PosX
			lw $a1, enemy1PosY
			lw $a2, enemy1Dir
			
			jal EraseAgent
			
			lw $a0, enemy1PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy1PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 1 # the enemy 1
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy1DirRight
			
			lw $t1, enemy1PosX
			addi $t1, $t1, 1
			sw $t1, enemy1PosX
						
			lw $a0, enemy1PosX
			lw $a1, enemy1PosY
			lw $a2, enemy1State
			lw $a3, enemy1Dir
			
			jal DrawAgent
			
			lw $a0, enemy1PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy1PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy1State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy1DirRight:
			
				li $t2, 1
				sw $t2, enemy1Dir # store in memory the new direction
				
				lw $a0, enemy1PosX
				lw $a1, enemy1PosY
				lw $a2, enemy1State
				lw $a3, enemy1Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy1
				
	TryMoveAgentEnemy2:
	
		bne $a0, 2, TryMoveAgentEnemy3
		
		lw $t0, enemy2Dir
		
		Enemy2MoveUp:
		
			bne $t0, 0, Enemy2MoveDown
			
			lw $a0, enemy2PosX
			lw $a1, enemy2PosY
			lw $a2, enemy2Dir
			
			jal EraseAgent
			
			lw $a0, enemy2PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy2PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 2 # the enemy 2
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy2DirUp		
			
			lw $t1, enemy2PosY
			addi $t1, $t1, -1
			sw $t1, enemy2PosY	
		
			lw $a0, enemy2PosX
			lw $a1, enemy2PosY
			lw $a2, enemy2State
			lw $a3, enemy2Dir
			
			jal DrawAgent
			
			lw $a0, enemy2PosX
 			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy2PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy2State
			
			jal DrawPoint
				
			j TryMoveAgentDone
				
			ChangeEnemy2DirUp:
			
				li $t2, 2
				sw $t2, enemy2Dir # store in memory the new direction
				
				lw $a0, enemy2PosX
				lw $a1, enemy2PosY
				lw $a2, enemy2State
				lw $a3, enemy2Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy2
						
		Enemy2MoveDown:
		
			bne $t0, 1, Enemy2MoveLeft
			
			lw $a0, enemy2PosX
			lw $a1, enemy2PosY
			lw $a2, enemy2Dir
			
			jal EraseAgent
			
			lw $a0, enemy2PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy2PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 2 # the enemy 2
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy2DirDown
			
			lw $t1, enemy2PosY
			addi $t1, $t1, 1
			sw $t1, enemy2PosY
								
			lw $a0, enemy2PosX
			lw $a1, enemy2PosY
			lw $a2, enemy2State
			lw $a3, enemy2Dir
			
			jal DrawAgent
			
			lw $a0, enemy2PosX
            		srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy2PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy2State
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy2DirDown:
			
				li $t2, 0
				sw $t2, enemy2Dir # store in memory the new direction
				
				lw $a0, enemy2PosX
				lw $a1, enemy2PosY
				lw $a2, enemy2State
				lw $a3, enemy2Dir
			
				jal DrawAgent
										
				j TryMoveAgentEnemy2
			
		Enemy2MoveLeft:
		
			bne $t0, 2, Enemy2MoveRight
			
			lw $a0, enemy2PosX
			lw $a1, enemy2PosY
			lw $a2, enemy2Dir
			
			jal EraseAgent
			
			lw $a0, enemy2PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy2PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
				
			# Make the test to see if there is collision
			li $a0, 2 # the enemy 2
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy2DirLeft
			
			lw $t1, enemy2PosX
			addi $t1, $t1, -1
			sw $t1, enemy2PosX
						
			lw $a0, enemy2PosX
			lw $a1, enemy2PosY
			lw $a2, enemy2State
			lw $a3, enemy2Dir
		
			jal DrawAgent
			
			lw $a0, enemy2PosX
          		srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy2PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy2State
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy2DirLeft:
			
				li $t2, 3
				sw $t2, enemy2Dir # store in memory the new direction
				
				lw $a0, enemy2PosX
				lw $a1, enemy2PosY
				lw $a2, enemy2State
				lw $a3, enemy2Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy2
			
		Enemy2MoveRight:
		
			bne $t0, 3, TryMoveAgentDone
		
			lw $a0, enemy2PosX
			lw $a1, enemy2PosY
			lw $a2, enemy2Dir
			
			jal EraseAgent
			
			lw $a0, enemy2PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy2PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 2 # the enemy 2
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy2DirRight
			
			lw $t1, enemy2PosX
			addi $t1, $t1, 1
			sw $t1, enemy2PosX
						
			lw $a0, enemy2PosX
			lw $a1, enemy2PosY
			lw $a2, enemy2State
			lw $a3, enemy2Dir
			
			jal DrawAgent
			
			lw $a0, enemy2PosX
            		srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy2PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy2State
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy2DirRight:
			
				li $t2, 1
				sw $t2, enemy2Dir # store in memory the new direction
				
				lw $a0, enemy2PosX
				lw $a1, enemy2PosY
				lw $a2, enemy2State
				lw $a3, enemy2Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy2
		
	TryMoveAgentEnemy3:
	
		bne $a0, 3, TryMoveAgentEnemy4
		
		lw $t0, enemy3Dir
		
		Enemy3MoveUp:
		
			bne $t0, 0, Enemy3MoveDown
			
			lw $a0, enemy3PosX
			lw $a1, enemy3PosY
			lw $a2, enemy3Dir
			
			jal EraseAgent
			
			lw $a0, enemy3PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy3PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 3 # the enemy 3
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy3DirUp		
			
			lw $t1, enemy3PosY
			addi $t1, $t1, -1
			sw $t1, enemy3PosY	
			
			lw $a0, enemy3PosX
			lw $a1, enemy3PosY
			lw $a2, enemy3State
			lw $a3, enemy3Dir
			
			jal DrawAgent
			
			lw $a0, enemy3PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy3PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy3State			
			
			jal DrawPoint
				
			j TryMoveAgentDone
				
			ChangeEnemy3DirUp:
			
				li $t2, 2
				sw $t2, enemy3Dir # store in memory the new direction
				
				lw $a0, enemy3PosX
				lw $a1, enemy3PosY
				lw $a2, enemy3State
				lw $a3, enemy3Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy3
			
		Enemy3MoveDown:
		
			bne $t0, 1, Enemy3MoveLeft
			
			lw $a0, enemy3PosX
			lw $a1, enemy3PosY
			lw $a2, enemy3Dir
			
			jal EraseAgent
			
			lw $a0, enemy3PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy3PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 3 # the enemy 3
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy3DirDown
			
			lw $t1, enemy3PosY
			addi $t1, $t1, 1
			sw $t1, enemy3PosY
								
			lw $a0, enemy3PosX
			lw $a1, enemy3PosY
			lw $a2, enemy3State
			lw $a3, enemy3Dir
		
			jal DrawAgent
			
			lw $a0, enemy3PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy3PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy3State			
			
			jal DrawPoint
						
			j TryMoveAgentDone
				
			ChangeEnemy3DirDown:
			
				li $t2, 0
				sw $t2, enemy3Dir # store in memory the new direction
				
				lw $a0, enemy3PosX
				lw $a1, enemy3PosY
				lw $a2, enemy3State
				lw $a3, enemy3Dir
			
				jal DrawAgent
										
				j TryMoveAgentEnemy3
			
		Enemy3MoveLeft:
		
			bne $t0, 2, Enemy3MoveRight
			
			lw $a0, enemy3PosX
			lw $a1, enemy3PosY
			lw $a2, enemy3Dir
			
			jal EraseAgent
			
			lw $a0, enemy3PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy3PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
				
			# Make the test to see if there is collision
			li $a0, 3 # the enemy 3
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy3DirLeft
			
			lw $t1, enemy3PosX
			addi $t1, $t1, -1
			sw $t1, enemy3PosX
						
			lw $a0, enemy3PosX
			lw $a1, enemy3PosY
			lw $a2, enemy3State
			lw $a3, enemy3Dir
			
			jal DrawAgent
			
			lw $a0, enemy3PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy3PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy3State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy3DirLeft:
			
				li $t2, 3
				sw $t2, enemy3Dir # store in memory the new direction
				
				lw $a0, enemy3PosX
				lw $a1, enemy3PosY
				lw $a2, enemy3State
				lw $a3, enemy3Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy3
			
		Enemy3MoveRight:
		
			bne $t0, 3, TryMoveAgentDone
		
			lw $a0, enemy3PosX
			lw $a1, enemy3PosY
			lw $a2, enemy3Dir
			
			jal EraseAgent
			
			lw $a0, enemy3PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy3PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 3 # the enemy 3
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy3DirRight
			
			lw $t1, enemy3PosX
			addi $t1, $t1, 1
			sw $t1, enemy3PosX
						
			lw $a0, enemy3PosX
			lw $a1, enemy3PosY
			lw $a2, enemy3State
			lw $a3, enemy3Dir
			
			jal DrawAgent
			
			lw $a0, enemy3PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy3PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy3State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy3DirRight:
			
				li $t2, 1
				sw $t2, enemy3Dir # store in memory the new direction
				
				lw $a0, enemy3PosX
				lw $a1, enemy3PosY
				lw $a2, enemy3State
				lw $a3, enemy3Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy3
		
	TryMoveAgentEnemy4:
	
		bne $a0, 4, TryMoveAgentEnemy5
		
		lw $t0, enemy4Dir
		
		Enemy4MoveUp:
		
			bne $t0, 0, Enemy4MoveDown
			
			lw $a0, enemy4PosX
			lw $a1, enemy4PosY
			lw $a2, enemy4Dir
			
			jal EraseAgent
			
			lw $a0, enemy4PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy4PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 4 # the enemy 4
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy4DirUp		
			
			lw $t1, enemy4PosY
			addi $t1, $t1, -1
			sw $t1, enemy4PosY		
			
			lw $a0, enemy4PosX
			lw $a1, enemy4PosY
			lw $a2, enemy4State
			lw $a3, enemy4Dir
			
			jal DrawAgent
			
			lw $a0, enemy4PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy4PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy4State			
			
			jal DrawPoint
				
			j TryMoveAgentDone
				
			ChangeEnemy4DirUp:
			
				li $t2, 2
				sw $t2, enemy4Dir # store in memory the new direction
				
				lw $a0, enemy4PosX
				lw $a1, enemy4PosY
				lw $a2, enemy4State
				lw $a3, enemy4Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy4
			
		Enemy4MoveDown:
		
			bne $t0, 1, Enemy4MoveLeft
			
			lw $a0, enemy4PosX
			lw $a1, enemy4PosY
			lw $a2, enemy4Dir
			
			jal EraseAgent
			
			lw $a0, enemy4PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy4PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 4 # the enemy 4
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy4DirDown
			
			lw $t1, enemy4PosY
			addi $t1, $t1, 1
			sw $t1, enemy4PosY
								
			lw $a0, enemy4PosX
			lw $a1, enemy4PosY
			lw $a2, enemy4State
			lw $a3, enemy4Dir
			
			jal DrawAgent
			
			lw $a0, enemy4PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy4PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy4State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy4DirDown:
			
				li $t2, 0
				sw $t2, enemy4Dir # store in memory the new direction
				
				lw $a0, enemy4PosX
				lw $a1, enemy4PosY
				lw $a2, enemy4State
				lw $a3, enemy4Dir
			
				jal DrawAgent
										
				j TryMoveAgentEnemy4
			
		Enemy4MoveLeft:
		
			bne $t0, 2, Enemy4MoveRight
			
			lw $a0, enemy4PosX
			lw $a1, enemy4PosY
			lw $a2, enemy4Dir
			
			jal EraseAgent
			
			lw $a0, enemy4PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy4PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
				
			# Make the test to see if there is collision
			li $a0, 4 # the enemy 4
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy4DirLeft
			
			lw $t1, enemy4PosX
			addi $t1, $t1, -1
			sw $t1, enemy4PosX
						
			lw $a0, enemy4PosX
			lw $a1, enemy4PosY
			lw $a2, enemy4State
			lw $a3, enemy4Dir
			
			jal DrawAgent
			
			lw $a0, enemy4PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy4PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy4State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy4DirLeft:
			
				li $t2, 3
				sw $t2, enemy4Dir # store in memory the new direction
				
				lw $a0, enemy4PosX
				lw $a1, enemy4PosY
				lw $a2, enemy4State
				lw $a3, enemy4Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy4
			
		Enemy4MoveRight:
		
			bne $t0, 3, TryMoveAgentDone
		
			lw $a0, enemy4PosX
			lw $a1, enemy4PosY
			lw $a2, enemy4Dir
			
			jal EraseAgent
			
			lw $a0, enemy4PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy4PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 4 # the enemy 4
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy4DirRight
			
			lw $t1, enemy4PosX
			addi $t1, $t1, 1
			sw $t1, enemy4PosX
						
			lw $a0, enemy4PosX
			lw $a1, enemy4PosY
			lw $a2, enemy4State
			lw $a3, enemy4Dir
		
			jal DrawAgent
			
			lw $a0, enemy4PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy4PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy4State			
			
			jal DrawPoint
		
			j TryMoveAgentDone
				
			ChangeEnemy4DirRight:
			
				li $t2, 1
				sw $t2, enemy4Dir # store in memory the new direction
				
				lw $a0, enemy4PosX
				lw $a1, enemy4PosY
				lw $a2, enemy4State
				lw $a3, enemy4Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy4
		
	TryMoveAgentEnemy5:
	
		bne $a0, 5, TryMoveAgentEnemy6
		
		lw $t0, enemy5Dir
		
		Enemy5MoveUp:
		
			bne $t0, 0, Enemy5MoveDown
			
			lw $a0, enemy5PosX
			lw $a1, enemy5PosY
			lw $a2, enemy5Dir
			
			jal EraseAgent
			
			lw $a0, enemy5PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy5PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 5 # the enemy 5
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy5DirUp		
			
			lw $t1, enemy5PosY
			addi $t1, $t1, -1
			sw $t1, enemy5PosY	
			
			lw $a0, enemy5PosX
			lw $a1, enemy5PosY
			lw $a2, enemy5State
			lw $a3, enemy5Dir
			
			jal DrawAgent
			
			lw $a0, enemy5PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy5PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy5State			
			
			jal DrawPoint
				
			j TryMoveAgentDone
				
			ChangeEnemy5DirUp:
			
				li $t2, 2
				sw $t2, enemy5Dir # store in memory the new direction
				
				lw $a0, enemy5PosX
				lw $a1, enemy5PosY
				lw $a2, enemy5State
				lw $a3, enemy5Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy5
			
		Enemy5MoveDown:
		
			bne $t0, 1, Enemy5MoveLeft
			
			lw $a0, enemy5PosX
			lw $a1, enemy5PosY
			lw $a2, enemy5Dir
			
			jal EraseAgent
			
			lw $a0, enemy5PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy5PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 5 # the enemy 5
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy5DirDown
			
			lw $t1, enemy5PosY
			addi $t1, $t1, 1
			sw $t1, enemy5PosY
								
			lw $a0, enemy5PosX
			lw $a1, enemy5PosY
			lw $a2, enemy5State
			lw $a3, enemy5Dir
			
			jal DrawAgent
			
			lw $a0, enemy5PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy5PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy5State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy5DirDown:
			
				li $t2, 0
				sw $t2, enemy5Dir # store in memory the new direction
				
				lw $a0, enemy5PosX
				lw $a1, enemy5PosY
				lw $a2, enemy5State
				lw $a3, enemy5Dir
			
				jal DrawAgent
										
				j TryMoveAgentEnemy5
			
		Enemy5MoveLeft:
		
			bne $t0, 2, Enemy5MoveRight
			
			lw $a0, enemy5PosX
			lw $a1, enemy5PosY
			lw $a2, enemy5Dir
			
			jal EraseAgent
			
			lw $a0, enemy5PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy5PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
				
			# Make the test to see if there is collision
			li $a0, 5 # the enemy 5
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy5DirLeft
			
			lw $t1, enemy5PosX
			addi $t1, $t1, -1
			sw $t1, enemy5PosX
						
			lw $a0, enemy5PosX
			lw $a1, enemy5PosY
			lw $a2, enemy5State
			lw $a3, enemy5Dir
			
			jal DrawAgent
			
			lw $a0, enemy5PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy5PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy5State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy5DirLeft:
			
				li $t2, 3
				sw $t2, enemy5Dir # store in memory the new direction
				
				lw $a0, enemy5PosX
				lw $a1, enemy5PosY
				lw $a2, enemy5State
				lw $a3, enemy5Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy5
			
		Enemy5MoveRight:
		
			bne $t0, 3, TryMoveAgentDone
		
			lw $a0, enemy5PosX
			lw $a1, enemy5PosY
			lw $a2, enemy5Dir
			
			jal EraseAgent
			
			lw $a0, enemy5PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy5PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 5 # the enemy 5
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy5DirRight
			
			lw $t1, enemy5PosX
			addi $t1, $t1, 1
			sw $t1, enemy5PosX
						
			lw $a0, enemy5PosX
			lw $a1, enemy5PosY
			lw $a2, enemy5State
			lw $a3, enemy5Dir
			
			jal DrawAgent
			
			lw $a0, enemy5PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy5PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy5State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy5DirRight:
			
				li $t2, 1
				sw $t2, enemy5Dir # store in memory the new direction
				
				lw $a0, enemy5PosX
				lw $a1, enemy5PosY
				lw $a2, enemy5State
				lw $a3, enemy5Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy5
		
	TryMoveAgentEnemy6:
	
		bne $a0, 6, TryMoveAgentDone
		
		lw $t0, enemy6Dir
		
		Enemy6MoveUp:
		
			bne $t0, 0, Enemy6MoveDown
			
			lw $a0, enemy6PosX
			lw $a1, enemy6PosY
			lw $a2, enemy6Dir
			
			jal EraseAgent
			
			lw $a0, enemy6PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy6PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 6 # the enemy 6
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy6DirUp		
			
			lw $t1, enemy6PosY
			addi $t1, $t1, -1
			sw $t1, enemy6PosY	
			
			lw $a0, enemy6PosX
			lw $a1, enemy6PosY
			lw $a2, enemy6State
			lw $a3, enemy6Dir
			
			jal DrawAgent
			
			lw $a0, enemy6PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy6PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy6State			
			
			jal DrawPoint
				
			j TryMoveAgentDone
				
			ChangeEnemy6DirUp:
			
				li $t2, 2
				sw $t2, enemy6Dir # store in memory the new direction
			
				lw $a0, enemy6PosX
				lw $a1, enemy6PosY
				lw $a2, enemy6State
				lw $a3, enemy6Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy6
			
		Enemy6MoveDown:
		
			bne $t0, 1, Enemy6MoveLeft
			
			lw $a0, enemy6PosX
			lw $a1, enemy6PosY
			lw $a2, enemy6Dir
			
			jal EraseAgent
			
			lw $a0, enemy6PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy6PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 6 # the enemy 6
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy6DirDown
			
			lw $t1, enemy6PosY
			addi $t1, $t1, 1
			sw $t1, enemy6PosY
								
			lw $a0, enemy6PosX
			lw $a1, enemy6PosY
			lw $a2, enemy6State
			lw $a3, enemy6Dir
			
			jal DrawAgent
			
			lw $a0, enemy6PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy6PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy6State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy6DirDown:
			
				li $t2, 0
				sw $t2, enemy6Dir # store in memory the new direction
				
				lw $a0, enemy6PosX
				lw $a1, enemy6PosY
				lw $a2, enemy6State
				lw $a3, enemy6Dir
			
				jal DrawAgent
										
				j TryMoveAgentEnemy6
			
		Enemy6MoveLeft:
		
			bne $t0, 2, Enemy6MoveRight
			
			lw $a0, enemy6PosX
			lw $a1, enemy6PosY
			lw $a2, enemy6Dir
			
			jal EraseAgent
			
			lw $a0, enemy6PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy6PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
				
			# Make the test to see if there is collision
			li $a0, 6 # the enemy 6
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy6DirLeft
			
			lw $t1, enemy6PosX
			addi $t1, $t1, -1
			sw $t1, enemy6PosX
						
			lw $a0, enemy6PosX
			lw $a1, enemy6PosY
			lw $a2, enemy6State
			lw $a3, enemy6Dir
			
			jal DrawAgent
			
			lw $a0, enemy6PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy6PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy6State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy6DirLeft:
			
				li $t2, 3
				sw $t2, enemy6Dir # store in memory the new direction
				
				lw $a0, enemy6PosX
				lw $a1, enemy6PosY
				lw $a2, enemy6State
				lw $a3, enemy6Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy6
			
		Enemy6MoveRight:
		
			bne $t0, 3, TryMoveAgentDone
		
			lw $a0, enemy6PosX
			lw $a1, enemy6PosY
			lw $a2, enemy6Dir
			
			jal EraseAgent
			
			lw $a0, enemy6PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy6PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, backgroundColor			
			
			jal DrawPoint
			
			# Make the test to see if there is collision
			li $a0, 6 # the enemy 6
			li $a1, 0 # requiered for recursion
			
			jal CheckCollision			
			
			bne $v0, 0, ChangeEnemy6DirRight
			
			lw $t1, enemy6PosX
			addi $t1, $t1, 1
			sw $t1, enemy6PosX
						
			lw $a0, enemy6PosX
			lw $a1, enemy6PosY
			lw $a2, enemy6State
			lw $a3, enemy6Dir
			
			jal DrawAgent
			
			lw $a0, enemy6PosX
			srl $a0, $a0, 1
			addi $a0, $a0, 17			
			lw $a1, enemy6PosY
			srl $a1, $a1, 1
			addi $a1, $a1, 43
			lw $a2, enemy6State			
			
			jal DrawPoint
			
			j TryMoveAgentDone
				
			ChangeEnemy6DirRight:
			
				li $t2, 1
				sw $t2, enemy6Dir # store in memory the new direction
				
				lw $a0, enemy6PosX
				lw $a1, enemy6PosY
				lw $a2, enemy6State
				lw $a3, enemy6Dir
			
				jal DrawAgent
								
				j TryMoveAgentEnemy6
				
	TryMoveAgentDone:
	
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		
		jr $ra
		
		
# $a0 x position
# $a1 y position
# $a2 contains the color
# #a3 direction	
DrawAgent:

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)

	AgentUp:
	
		bne $a3, 0, AgentDown
		
		addi $a0, $a0, 1		
		add $a3, $a0, 0
		
		jal DrawHorizontalLine	
		
		lw $a0, 4($sp) # Recover x value
		lw $a1, 8($sp) # Recover y value
		addi $a1, $a1, 1
		addi $a3, $a0, 2
		
		jal DrawHorizontalLine
				
		lw $a0, 4($sp) # Recover x value
		lw $a1, 8($sp) # Recover y value
		addi $a1, $a1, 2
		addi $a3, $a0, 2
		
		jal DrawHorizontalLine
				
		j EndDrawAgent
						
	AgentDown:
	
		bne $a3, 1, AgentLeft
						
		addi $a0, $a0, 1
		addi $a1, $a1, 2	
		add $a3, $a0, 0
		
		jal DrawHorizontalLine	
		
		lw $a0, 4($sp) # Recover x value
		lw $a1, 8($sp) # Recover y value
		addi $a1, $a1, 0
		addi $a3, $a0, 2
		
		jal DrawHorizontalLine
				
		lw $a0, 4($sp) # Recover x value
		lw $a1, 8($sp) # Recover y value
		addi $a1, $a1, 1
		addi $a3, $a0, 2
		
		jal DrawHorizontalLine
				
		j EndDrawAgent
		
	AgentLeft:
	
		bne $a3, 2, AgentRight
				
		addi $a0, $a0, 1		
		add $a3, $a0, 1
		
		jal DrawHorizontalLine	
		
		lw $a0, 4($sp) # Recover x value
		lw $a1, 8($sp) # Recover y value
		addi $a1, $a1, 1
		addi $a3, $a0, 2
		
		jal DrawHorizontalLine
				
		lw $a0, 4($sp) # Recover x value
		lw $a1, 8($sp) # Recover y value
		addi $a0, $a0, 1
		addi $a1, $a1, 2
		addi $a3, $a0, 1
		
		jal DrawHorizontalLine
				
		j EndDrawAgent
		
	AgentRight:
	
		bne $a3, 3, EndDrawAgent
						
		add $a3, $a0, 1
		
		jal DrawHorizontalLine	
		
		lw $a0, 4($sp) # Recover x value
		lw $a1, 8($sp) # Recover y value
		addi $a1, $a1, 1
		addi $a3, $a0, 2
		
		jal DrawHorizontalLine
				
		lw $a0, 4($sp) # Recover x value
		lw $a1, 8($sp) # Recover y value
		addi $a1, $a1, 2
		addi $a3, $a0, 1
		
		jal DrawHorizontalLine
				
	EndDrawAgent:
	
		lw $ra, 0($sp)	
		addi $sp, $sp, 12
		
		jr $ra

																																																		
# $a0 x position
# $a1 y position
# $a2 direction
EraseAgent:

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	
	EraseAgentUp:
	
		bne $a2, 0, EraseAgentDown
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		addi $a1, $a1, 2
		li $a2, 0
		addi $a3, $a0, 2
		
		jal DrawHorizontalLine
		
		j EndEraseAgent	
						
	EraseAgentDown:
	
		bne $a2, 1, EraseAgentLeft
			
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		li $a2, 0
		addi $a3, $a0, 2
		
		jal DrawHorizontalLine
		
		j EndEraseAgent	

	EraseAgentLeft:
	
		bne $a2, 2, EraseAgentRight
		
		lw $a0, 4($sp)
		addi $a0, $a0, 2
		lw $a1, 8($sp)
		li $a2, 0
		addi $a3, $a1, 2
		
		jal DrawVerticalLine
		
		j EndEraseAgent		
		
	EraseAgentRight:
	
		bne $a2, 3, EndEraseAgent
		
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		li $a2, 0
		addi $a3, $a1, 2
		
		jal DrawVerticalLine
		
		j EndEraseAgent
			
	EndEraseAgent:
	
		lw $ra, 0($sp)	
		addi $sp, $sp, 12
		
		jr $ra																																
			
																																				
# $a0 x position
# $a1 y position
EraseCompleteAgent:

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
		
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	li $a2, 0
	addi $a3, $a0, 2
		
	jal DrawHorizontalLine
			
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $a1, $a1, 1
	li $a2, 0
	addi $a3, $a0, 2
		
	jal DrawHorizontalLine
		
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $a1, $a1, 2
	li $a2, 0
	addi $a3, $a0, 2
		
	jal DrawHorizontalLine
		
	lw $ra, 0($sp)	
	addi $sp, $sp, 12
		
	jr $ra																																																																						
																																																																																																																																																																																																																																																																																																												
			
# $a0 the x starting coordinate
# $a1 the y coordinate
# $a2 the color
# $a3 the x ending coordinate
DrawHorizontalLine:
		
	addi $sp, $sp, -4
   	sw $ra, 0($sp)
	
	sub $t9, $a3, $a0
	move $t1, $a0
		
	HorizontalLoop:
		
		add $a0, $t1, $t9
		jal DrawPoint
		addi $t9, $t9, -1
		
		bge $t9, 0, HorizontalLoop
		
		lw $ra, 0($sp)		# put return back
   		addi $sp, $sp, 4

		jr $ra
		
		
# $a0 the x coordinate
# $a1 the y starting coordinate
# $a2 the color
# $a3 the y ending coordinate
DrawVerticalLine:

	addi $sp, $sp, -4
   	sw $ra, 0($sp)
	
	sub $t9, $a3, $a1
	move $t1, $a1
		
	VerticalLoop:
		
		add $a1, $t1, $t9
		jal DrawPoint
		addi $t9, $t9, -1
		
		bge $t9, 0, VerticalLoop
		
		lw $ra, 0($sp)		# put return back
   		addi $sp, $sp, 4
   		
		jr $ra
		
		
# $a0 contains x position
# $a1 contains y position
# $a2 contains the color	
DrawPoint:

	sll $t0, $a1, 6   # multiply y-coordinate by 64 (length of the field)
	addu $v0, $a0, $t0
	sll $v0, $v0, 2
	addu $v0, $v0, $gp
	sw $a2, ($v0)		# draw the color to the location
		
	jr $ra
	
		
# Check Collison Function
# $a0 agent
# $a1 must be zero
CheckCollision:

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $ra, 4($sp)
	sw $a1, 8($sp)
	
	beq $a0, $a1, CheckCol
	
	addi $a1, $a1, 1
	
	jal CheckCollision
	
	CheckCol:
	
		PlayerCol:
		
			bne $a0, 0, Enemy1Col
			
			lw $a0, playerPosX
			lw $a1, playerPosY
			li $a2, 4
			lw $a3, playerDir
			
			jal CollisionDirection
			
			j CheckCollisionDone
			
		Enemy1Col:
	
			bne $a0, 1, Enemy2Col
			
			lw $a0, enemy1PosX
			lw $a1, enemy1PosY
			li $a2, 4
			lw $a3, enemy1Dir
			
			jal CollisionDirection
			
			j CheckCollisionDone
			
		Enemy2Col:	
	
			bne $a0, 2, Enemy3Col
			
			lw $a0, enemy2PosX
			lw $a1, enemy2PosY
			li $a2, 4
			lw $a3, enemy2Dir
			
			jal CollisionDirection
			
			j CheckCollisionDone
			
		Enemy3Col:
	
			bne $a0, 3, Enemy4Col
			
			lw $a0, enemy3PosX
			lw $a1, enemy3PosY
			li $a2, 4
			lw $a3, enemy3Dir
			
			jal CollisionDirection
			
			j CheckCollisionDone
			
		Enemy4Col:
	
			bne $a0, 4, Enemy5Col
			
			lw $a0, enemy4PosX
			lw $a1, enemy4PosY
			li $a2, 4
			lw $a3, enemy4Dir
			
			jal CollisionDirection
			
			j CheckCollisionDone
		
		Enemy5Col:
	
			bne $a0, 5, Enemy6Col
			
			lw $a0, enemy5PosX
			lw $a1, enemy5PosY
			li $a2, 4
			lw $a3, enemy5Dir
			
			jal CollisionDirection
			
			j CheckCollisionDone
		
		Enemy6Col:
	
			bne $a0, 6, CheckCollisionDone
			
			lw $a0, enemy6PosX
			lw $a1, enemy6PosY
			li $a2, 4
			lw $a3, enemy6Dir
			
			jal CollisionDirection			
		
	CheckCollisionDone:
	
		lw $ra, 0($sp)
		addi $sp, $sp, 12
		
		jr $ra
		

#Auxiliar function to detect if there is a collision
# $a0 x position
# $a1 y position
# $a2 type
# $a3 direction
CollisionDirection:

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	CollUp:
	
		bne $a3, 0, CollDown
		
		addi $a1, $a1, -2 # ajust the coordinate for up
		
		Pixel0Up:
		
			addi $a0, $a0, -1
		
			jal LoadColor
			
			Pixel0UpPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel0UpOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel0UpOther:
			
				beq $v0, 0, Pixel1Up
						
				li $v0, 1
			
				j CollDone
			
		Pixel1Up:
		
			addi $a0, $a0, 1
			
			jal LoadColor
			
			Pixel1UpPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel1UpOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel1UpOther:
			
				beq $v0, 0, Pixel2Up
						
				li $v0, 1
			
				j CollDone
			
		Pixel2Up:
		
			addi $a0, $a0, 1
			
			jal LoadColor
			
			Pixel2UpPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel2UpOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel2UpOther:
			
				beq $v0, 0, Pixel3Up
					
				li $v0, 1
			
				j CollDone
			
		Pixel3Up: 
		
			addi $a0, $a0, 1
			
			jal LoadColor
			
			Pixel3UpPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel3UpOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel3UpOther:
			
				beq $v0, 0, Pixel4Up	
						
				li $v0, 1
			
				j CollDone
			
		Pixel4Up: 
		
			addi $a0, $a0, 1
			
			jal LoadColor
			
			Pixel4UpPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel4UpOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel4UpOther:
			
				beq $v0, 0, NoCollUp	
					
				li $v0, 1
			
				j CollDone
			
		NoCollUp:
		
			li $v0, 0
			
			j CollDone				
		
	CollDown:
	
		bne $a3, 1, CollLeft
		
		addi $a1, $a1, 4 # ajust the coordinate for down
		
		Pixel0Down:
		
			addi $a0, $a0, -1
		
			jal LoadColor
			
			Pixel0DownPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel0DownOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel0DownOther:
			
			beq $v0, 0, Pixel1Down	
					
			li $v0, 1
			
			j CollDone
			
		Pixel1Down:
		
			addi $a0, $a0, 1
			
			jal LoadColor
			
			Pixel1DownPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel1DownOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel1DownOther:
			
				beq $v0, 0, Pixel2Down	
					
				li $v0, 1
			
				j CollDone
			
		Pixel2Down:
		
			addi $a0, $a0, 1
			
			jal LoadColor
			
			Pixel2DownPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel2DownOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel2DownOther:
			
				beq $v0, 0, Pixel3Down	
					
				li $v0, 1
			
				j CollDone
			
		Pixel3Down: 
		
			addi $a0, $a0, 1
			
			jal LoadColor
			
			Pixel3DownPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel3DownOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel3DownOther:
			
				beq $v0, 0, Pixel4Down	
					
				li $v0, 1
			
				j CollDone
			
		Pixel4Down: 
		
			addi $a0, $a0, 1
			
			jal LoadColor
			
			Pixel4DownPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel4DownOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel4DownOther:
			
				beq $v0, 0, NoCollDown	
					
				li $v0, 1
			
				j CollDone
			
		NoCollDown:
		
			li $v0, 0
			
			j CollDone					 
		
	CollLeft:
	
		bne $a3, 2, CollRight
		
		addi $a0, $a0, -2 # ajust the coordinate for left
		
		Pixel0Left:
					
			jal LoadColor
			
			Pixel0LeftPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel0LeftOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel0LeftOther:
						
				beq $v0, 0, Pixel1Left	
				
				li $v0, 1
			
				j CollDone
			
		Pixel1Left:
		
			addi $a1, $a1, 1
			
			jal LoadColor
			
			Pixel1LeftPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel1LeftOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel1LeftOther:
			
				beq $v0, 0, Pixel2Left	
					
				li $v0, 1
			
				j CollDone
			
		Pixel2Left:
		
			addi $a1, $a1, 1
			
			jal LoadColor
			
			Pixel2LeftPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel2LeftOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel2LeftOther:
					
				beq $v0, 0, Pixel3Left	
					
				li $v0, 1
			
				j CollDone
			
		Pixel3Left: 
		
			addi $a1, $a1, 1
			
			jal LoadColor
			
			Pixel3LeftPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel3LeftOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel3LeftOther:
			
				beq $v0, 0, NoCollLeft	
					
				li $v0, 1
			
				j CollDone
			
		NoCollLeft:
		
			li $v0, 0
			
			j CollDone
			
	CollRight:
	
		bne $a3, 3, CollDone
				
		addi $a0, $a0, 4 # ajust the coordinate for right
		
		Pixel0Right:
				
			jal LoadColor
			
			Pixel0RightPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel0RightOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel0RightOther:
			
				beq $v0, 0, Pixel1Right		
				
				li $v0, 1
			
				j CollDone
			
		Pixel1Right:
		
			addi $a1, $a1, 1
			
			jal LoadColor
			
			Pixel1RightPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel1RightOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel1RightOther:
			
				beq $v0, 0, Pixel2Right		
				
				li $v0, 1
			
				j CollDone
			
		Pixel2Right:
		
			addi $a1, $a1, 1
			
			jal LoadColor
			
			Pixel2RightPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel2RightOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel2RightOther:
			
				beq $v0, 0, Pixel3Right	
					
				li $v0, 1
			
				j CollDone
			
		Pixel3Right: 
		
			addi $a1, $a1, 1
			
			jal LoadColor
			
			Pixel3RightPlayer:
			
				lw $t0, playerState
				
				bne $v0, $t0, Pixel3RightOther	
				
				li $t0, 0
				sw $t0, playerActive
				
				lw $a0, playerPosX
				lw $a1, playerPosY
				
				jal EraseCompleteAgent
				
				li $v0, 0
			
				j CollDone		
			
			Pixel3RightOther:
			
				beq $v0, 0, NoCollRight	
					
				li $v0, 1
			
				j CollDone
			
		NoCollRight:
		
			li $v0, 0
			
			j CollDone
		
	CollDone:
	
		lw $ra, 0($sp)
		addi $sp, $sp, 4
	
		jr $ra


# $a0 x
# $a1 y	
LoadColor:	

	sll $t0, $a1, 6
	addu $v0, $a0, $t0
	sll $v0, $v0, 2
	addu $v0, $v0, $gp
	lw $v0, 0($v0)
	
	jr $ra
			
		
# Makes the entire bitmap display the background color (black)
ClearBoard:

	lw $t0, backgroundColor
	li $t1, 16384 # The number of pixels in the display
		
	StartCLoop:
	
		subi $t1, $t1, 4
		addu $t2, $t1, $gp
		sw $t0, ($t2)
		beqz $t1, EndCLoop
		
		j StartCLoop
		
	EndCLoop:
	
		jr $ra	
		
		
EndGame:

	# Player
	li $t0, 9
	sw $t0, playerPosX
	
	li $t0, 2
	sw $t0,playerPosY
	
	li $t0, 3
	sw $t0, playerDir
	
	li $t0, 0x00ffc800
	sw $t0, playerState
	
	li $t0, 1
	sw $t0, playerActive

	# PlayerBullet	
	li $t0, 0
	sw $t0, playerBulletActive
	
	li $t0, 0
	sw $t0,playerBulletPosX
	
	li $t0, 0
	sw $t0, playerBulletPosY
	
	li $t0, 0
	sw $t0, playerBulletDir
	
	li $t0, 0x00ffffff
	sw $t0, playerBulletState
		
	# PlayerScore
	li $t0, 0
	sw $t0, playerScoreNumber
	
	li $t0, 14
	sw $t0, playerScorePosX
	
	li $t0, 39
	sw $t0, playerScorePosY
	
	li $t0, 0x00ffffff
	sw $t0, playerScoreState
	
	# Enemy 1
	li $t0, 53
	sw $t0, enemy1PosX
	
	li $t0, 2
	sw $t0, enemy1PosY
	
	li $t0, 2
	sw $t0, enemy1Dir
	
	li $t0, 0x00fc0303 # Red
	sw $t0, enemy1State
	
	li $t0, 1
	sw $t0, enemy1Active
		
	# Enemy 2
	li $t0, 53
	sw $t0, enemy2PosX
	
	li $t0, 20
	sw $t0, enemy2PosY
	
	li $t0, 2
	sw $t0, enemy2Dir
	
	li $t0, 0x00ff6f00 # Orange
	sw $t0, enemy2State
	
	li $t0, 1
	sw $t0, enemy2Active
	
	# Enemy 3
	li $t0, 19
	sw $t0, enemy3PosX
	
	li $t0, 32
	sw $t0, enemy3PosY
	
	li $t0, 0
	sw $t0, enemy3Dir
	
	li $t0, 0x0011ff00 # Green
	sw $t0, enemy3State
	
	li $t0, 1
	sw $t0, enemy3Active
	
	# Enemy 4
	li $t0, 31
	sw $t0, enemy4PosX
	
	li $t0, 32
	sw $t0, enemy4PosY
	
	li $t0, 0
	sw $t0, enemy4Dir
	
	li $t0, 0x0000e5ff # Light blue
	sw $t0, enemy4State
	
	li $t0, 1
	sw $t0, enemy4Active
	
	# Enemy 5
	li $t0, 43
	sw $t0, enemy5PosX
	
	li $t0, 32
	sw $t0, enemy5PosY
	
	li $t0, 0
	sw $t0, enemy5Dir
	
	li $t0, 0x007700ff # Purple
	sw $t0, enemy5State
	
	li $t0, 1
	sw $t0, enemy5Active
	
	# Enemy 6
	li $t0, 9
	sw $t0, enemy6PosX
	
	li $t0, 20
	sw $t0, enemy6PosY
	
	li $t0, 3
	sw $t0, enemy6Dir
	
	li $t0, 0x00ff00e6 # Pink
	sw $t0, enemy6State
	
	li $t0, 1
	sw $t0, enemy6Active
	
	li $t0, 1
	sw $t0, rounds
	
	j NewGame
		

NewRound:

	# Player
	li $t0, 9
	sw $t0, playerPosX
	
	li $t0, 2
	sw $t0,playerPosY
	
	li $t0, 3
	sw $t0, playerDir
	
	li $t0, 0x00ffc800
	sw $t0, playerState
	
	li $t0, 1
	sw $t0, playerActive

	# PlayerBullet	
	li $t0, 0
	sw $t0, playerBulletActive
	
	li $t0, 0
	sw $t0,playerBulletPosX
	
	li $t0, 0
	sw $t0, playerBulletPosY
	
	li $t0, 0
	sw $t0, playerBulletDir
	
	li $t0, 0x00ffffff
	sw $t0, playerBulletState	
	
	# Enemy 1
	li $t0, 53
	sw $t0, enemy1PosX
	
	li $t0, 2
	sw $t0, enemy1PosY
	
	li $t0, 2
	sw $t0, enemy1Dir
	
	li $t0, 0x00fc0303 # Red
	sw $t0, enemy1State
	
	li $t0, 1
	sw $t0, enemy1Active
		
	# Enemy 2
	li $t0, 53
	sw $t0, enemy2PosX
	
	li $t0, 20
	sw $t0, enemy2PosY
	
	li $t0, 2
	sw $t0, enemy2Dir
	
	li $t0, 0x00ff6f00 # Orange
	sw $t0, enemy2State
	
	li $t0, 1
	sw $t0, enemy2Active
	
	# Enemy 3
	li $t0, 19
	sw $t0, enemy3PosX
	
	li $t0, 32
	sw $t0, enemy3PosY
	
	li $t0, 0
	sw $t0, enemy3Dir
	
	li $t0, 0x0011ff00 # Green
	sw $t0, enemy3State
	
	li $t0, 1
	sw $t0, enemy3Active
	
	# Enemy 4
	li $t0, 31
	sw $t0, enemy4PosX
	
	li $t0, 32
	sw $t0, enemy4PosY
	
	li $t0, 0
	sw $t0, enemy4Dir
	
	li $t0, 0x0000e5ff # Light blue
	sw $t0, enemy4State
	
	li $t0, 1
	sw $t0, enemy4Active
	
	# Enemy 5
	li $t0, 43
	sw $t0, enemy5PosX
	
	li $t0, 32
	sw $t0, enemy5PosY
	
	li $t0, 0
	sw $t0, enemy5Dir
	
	li $t0, 0x007700ff # Purple
	sw $t0, enemy5State
	
	li $t0, 1
	sw $t0, enemy5Active
	
	# Enemy 6
	li $t0, 9
	sw $t0, enemy6PosX
	
	li $t0, 20
	sw $t0, enemy6PosY
	
	li $t0, 3
	sw $t0, enemy6Dir
	
	li $t0, 0x00ff00e6 # Pink
	sw $t0, enemy6State
	
	li $t0, 1
	sw $t0, enemy6Active
	
	# Draw player						
	lw $a0, playerPosX
	lw $a1, playerPosY
	lw $a2, playerState
	lw $a3, playerDir
	
	jal DrawAgent
	
	# Draw enemy1			
	lw $a0, enemy1PosX
	lw $a1, enemy1PosY
	lw $a2, enemy1State
	lw $a3, enemy1Dir
	
	jal DrawAgent
	
	# Draw enemy2			
	lw $a0, enemy2PosX
	lw $a1, enemy2PosY
	lw $a2, enemy2State
	lw $a3, enemy2Dir
	
	jal DrawAgent
	
	# Draw enemy3		
	lw $a0, enemy3PosX
	lw $a1, enemy3PosY
	lw $a2, enemy3State
	lw $a3, enemy3Dir
	
	jal DrawAgent
	
	# Draw enemy4			
	lw $a0, enemy4PosX
	lw $a1, enemy4PosY
	lw $a2, enemy4State
	lw $a3, enemy4Dir
	
	jal DrawAgent
	
	# Draw enemy5		
	lw $a0, enemy5PosX
	lw $a1, enemy5PosY
	lw $a2, enemy5State
	lw $a3, enemy5Dir
	
	jal DrawAgent
	
	# Draw enemy6
	lw $a0, enemy6PosX
	lw $a1, enemy6PosY
	lw $a2, enemy6State
	lw $a3, enemy6Dir
	
	jal DrawAgent
	
	j Begin_standby
		