import kivy
from ewmh import EWMH
from kivy.app import App
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.core.window import Window
from kivy.config import Config
import os
import subprocess

Window.size = (800, 480)
Window.borderless = True
ewmh = EWMH()
win = None

# Create Screens
class RootScreen(ScreenManager):
    pass

class HomeScreen(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

class DemosScreen(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

class SeriousGamesScreen(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

class ConfigScreen(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

class QiskitScreen(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

class InfoScreen(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

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