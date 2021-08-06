import kivy
from kivy.app import App
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.config import Config
import os
import subprocess

Config.set('graphics', 'width', '795')
Config.set('graphics', 'height', '445')
Config.write()

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

class Main(App):
    def build(self):
        return RootScreen()

# run
if __name__ == "__main__":
    Main().run()