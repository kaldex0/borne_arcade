import pygame, random
from ui.utils.note import Note

try:
    import librosa
    _HAS_LIBROSA = True
except Exception as e:
    _HAS_LIBROSA = False
    _LIBROSA_ERR = e

class Piano:
    def __init__(self, gameview):
        self.__gameView = gameview
        self.__filepath = "./assets/music/" + self.__gameView.getWindowManager().getMusicSelect().lower().replace('play musique ', '').replace(' ', '').replace("'", '').replace(',', '') + ".mp3"
        self.__difficulty = 1
        self.__start_ticks = None
        self.__notes = self.generate_notes()

    def getNotes(self):
        return self.__notes

    def increaseDifficulty(self):
        self.__difficulty += 1

    def play(self):
        try:
            if not pygame.mixer.get_init():
                pygame.mixer.init()
            pygame.mixer.music.load(self.__filepath)
            pygame.mixer.music.play()
        except Exception as e:
            print(f"Warning: lecture audio impossible: {e}")
        self.__start_ticks = pygame.time.get_ticks()

    def pause(self):
        try:
            pygame.mixer.music.pause()
        except Exception:
            pass

    def generate_notes(self):
        print("Génération des notes à partir du fichier :", self.__filepath)
        notes = []

        if _HAS_LIBROSA:
            # Charger le fichier en mono, à faible sample rate (optimisation mémoire)
            y, sr = librosa.load(self.__filepath, sr=22050, mono=True)

            # Analyse du rythme
            tempo, beat_frames = librosa.beat.beat_track(y=y, sr=sr)
            beat_times = librosa.frames_to_time(beat_frames, sr=sr)

            for time in beat_times:
                nb_notes = min(self.__difficulty, random.randint(1, 4))
                for _ in range(nb_notes):
                    position = random.choice(["left", "middle", "right", "top"])
                    note = Note(gameview=self.__gameView, position=position, timestamp=time)
                    notes.append(note)
        else:
            # Fallback simple si librosa n'est pas disponible
            print(f"Warning: librosa indisponible ({_LIBROSA_ERR}). Fallback notes fixes.")
            duration_sec = 60
            interval = 0.5
            t = 0.0
            while t < duration_sec:
                nb_notes = min(self.__difficulty, random.randint(1, 4))
                for _ in range(nb_notes):
                    position = random.choice(["left", "middle", "right", "top"])
                    notes.append(Note(gameview=self.__gameView, position=position, timestamp=t))
                t += interval

        print(f"{len(notes)} notes générées.")
        return notes

    def getCurrentTime(self):
        try:
            pos = pygame.mixer.music.get_pos()
            if pos >= 0:
                return pos / 1000.0
        except Exception:
            pass

        if self.__start_ticks is None:
            return 0.0
        return (pygame.time.get_ticks() - self.__start_ticks) / 1000.0
