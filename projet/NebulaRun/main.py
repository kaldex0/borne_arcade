import os
import sys
import random
import time

try:
    import pygame
except Exception as exc:
    print("Pygame introuvable. Installez python3-pygame.")
    print(exc)
    sys.exit(1)

WIDTH = 1280
HEIGHT = 1024
FPS = 60

PLAYER_W = 60
PLAYER_H = 20
PLAYER_SPEED = 8

STAR_MIN = 6
STAR_MAX = 14
STAR_SPEED_MIN = 4
STAR_SPEED_MAX = 9
SPAWN_MS = 350

BG_COLOR = (10, 10, 25)
PLAYER_COLOR = (80, 200, 255)
STAR_COLOR = (255, 220, 120)
TEXT_COLOR = (240, 240, 240)


def reset_state():
    return {
        "x": WIDTH // 2 - PLAYER_W // 2,
        "y": HEIGHT - 120,
        "stars": [],
        "score": 0,
        "alive": True,
        "start": time.time(),
    }


def main():
    pygame.init()
    global WIDTH, HEIGHT
    info = pygame.display.Info()
    WIDTH = int(os.getenv("ARCADE_WIDTH", info.current_w or WIDTH))
    HEIGHT = int(os.getenv("ARCADE_HEIGHT", info.current_h or HEIGHT))
    fullscreen = os.getenv("ARCADE_FULLSCREEN", "1") == "1"
    flags = pygame.FULLSCREEN if fullscreen else 0
    screen = pygame.display.set_mode((WIDTH, HEIGHT), flags)
    pygame.display.set_caption("NebulaRun")
    clock = pygame.time.Clock()

    font = pygame.font.SysFont("Arial", 24)
    big = pygame.font.SysFont("Arial", 48)

    state = reset_state()
    pygame.time.set_timer(pygame.USEREVENT + 1, SPAWN_MS)

    running = True
    while running:
        dt = clock.tick(FPS)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.KEYDOWN:
                if event.key in (pygame.K_ESCAPE, pygame.K_q):
                    running = False
                if not state["alive"] and event.key == pygame.K_r:
                    state = reset_state()
            elif event.type == pygame.USEREVENT + 1 and state["alive"]:
                size = random.randint(STAR_MIN, STAR_MAX)
                sx = random.randint(0, WIDTH - size)
                sy = -size
                speed = random.randint(STAR_SPEED_MIN, STAR_SPEED_MAX)
                state["stars"].append([sx, sy, size, speed])

        keys = pygame.key.get_pressed()
        if state["alive"]:
            if keys[pygame.K_LEFT]:
                state["x"] -= PLAYER_SPEED
            if keys[pygame.K_RIGHT]:
                state["x"] += PLAYER_SPEED
            state["x"] = max(0, min(WIDTH - PLAYER_W, state["x"]))

        if state["alive"]:
            for star in state["stars"]:
                star[1] += star[3]
            state["stars"] = [s for s in state["stars"] if s[1] < HEIGHT + 50]

            player_rect = pygame.Rect(state["x"], state["y"], PLAYER_W, PLAYER_H)
            for star in state["stars"]:
                srect = pygame.Rect(star[0], star[1], star[2], star[2])
                if player_rect.colliderect(srect):
                    state["alive"] = False
                    break

            if state["alive"]:
                state["score"] = int(time.time() - state["start"])

        screen.fill(BG_COLOR)
        for star in state["stars"]:
            pygame.draw.rect(screen, STAR_COLOR, (star[0], star[1], star[2], star[2]))

        pygame.draw.rect(screen, PLAYER_COLOR, (state["x"], state["y"], PLAYER_W, PLAYER_H))

        score_text = font.render(f"Score: {state['score']}", True, TEXT_COLOR)
        screen.blit(score_text, (20, 20))

        hint = font.render("Fleches: gauche/droite | Q/Echap: quitter", True, TEXT_COLOR)
        screen.blit(hint, (20, HEIGHT - 40))

        if not state["alive"]:
            msg = big.render("GAME OVER", True, TEXT_COLOR)
            screen.blit(msg, (WIDTH // 2 - msg.get_width() // 2, HEIGHT // 2 - 60))
            sub = font.render("Appuie sur R pour rejouer", True, TEXT_COLOR)
            screen.blit(sub, (WIDTH // 2 - sub.get_width() // 2, HEIGHT // 2))

        pygame.display.flip()

    pygame.quit()


if __name__ == "__main__":
    main()
