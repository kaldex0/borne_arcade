import os
import pygame.font
import pygame.display

# Screen dimensions
def _detect_screen():
	width = int(os.getenv("ARCADE_WIDTH", "0"))
	height = int(os.getenv("ARCADE_HEIGHT", "0"))

	if width <= 0 or height <= 0:
		if not pygame.display.get_init():
			pygame.display.init()
		info = pygame.display.Info()
		width = info.current_w or 1240
		height = info.current_h or 1024

	return width, height


SCREEN_WIDTH, SCREEN_HEIGHT = _detect_screen()

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
RED = (255, 0, 0)
GREEN = (0,255,0)
BLUE = (0,0,255)

PLAYER_SPEED = 10

BALL_SPEED_X = 2
BALL_SPEED_FALL = 0.15
#BALL_TOP_BOUNCE = -11
BALL_TOP_BOUNCE = -17
#BALL_BOTTOM_BOUNCE = -9
BALL_BOTTOM_BOUNCE = -14
BALL_EQUIVALENT = 14
FIRERATE = 7

pygame.font.init()

#Fonts
FONT = pygame.font.SysFont('Comic Sans MS', 30)
FONT_SCORE = pygame.font.SysFont('Comic Sans MS', 18)