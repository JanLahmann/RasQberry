import kivy
from ewmh import EWMH
from kivy.app import App
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.core.window import Window
from kivy.config import Config
import os
import subprocess

#Config.set('graphics', 'width', '795')
#Config.set('graphics', 'height', '445')
#Config.write()

Window.size = (800, 480)
Window.borderless = True
ewmh = EWMH()
win = None

# Create Screens
class RootScreen(ScreenManager):
    pass

class HomeScreen(Screen):
    pass

class DemosScreen(Screen):
    pass

class SeriousGamesScreen(Screen):
    pass

class ConfigScreen(Screen):
    pass

class QiskitScreen(Screen):
    pass

class InfoScreen(Screen):
    pass

class SmallOverlay(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 800 - 100, 480 - 80, 80, 40)
        ewmh.display.flush()

class Main(App):
    def build(self):
        return RootScreen()

    def on_start(self):
        global win
        win = ewmh.getActiveWindow()
        ewmh.setWmState(win, 1, '_NET_WM_STATE_ABOVE')
        ewmh.display.flush()

# run
if __name__ == "__main__":
    Main().run()