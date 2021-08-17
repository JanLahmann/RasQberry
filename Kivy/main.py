from qiskit import ClassicalRegister, QuantumRegister, QuantumCircuit
from qiskit import execute, BasicAer
from ipywidgets import interact
import kivy
from ewmh import EWMH
from kivy.app import App
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.core.window import Window
from kivy.config import Config
from kivy.properties import StringProperty
from kivy.uix.image import Image

Window.size = (800, 480)
Window.borderless = True
ewmh = EWMH()
win = None

moveA1 = None
moveB1 = None
moveA2 = None

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

# Coin Game Screens
class CoinGameScreenRules(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

class QCoinGameScreenRules(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

class CoinGameScreenA1(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

    def xgatea1(self):
        global moveA1 
        moveA1 = 1
    def idgatea1(self):
        global moveA1
        moveA1 = 0

class QCoinGameScreenA1(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

    def xgatea1(self):
        global moveA1 
        moveA1 = 1
    
    def idgatea1(self):
        global moveA1
        moveA1 = 0
    
    def hgatea1(self):
        global moveA1
        moveA1 = 2

class CoinGameScreenB1(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()
    
    def xgateb1(self):
        global moveB1
        moveB1 = 1
    
    def idgateb1(self):
        global moveB1
        moveB1 = 0

class QCoinGameScreenB1(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()
    
    def xgateb1(self):
        global moveB1
        moveB1 = 1
    
    def idgateb1(self):
        global moveB1
        moveB1 = 0

class CoinGameScreenA2(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

    def xgatea2(self):
        global moveA2
        moveA2 = 1
    
    def idgatea2(self):
        global moveA2
        moveA2 = 0

class QCoinGameScreenA2(Screen):
    def on_pre_enter(self, *args):
        ewmh.setMoveResizeWindow(win, 0, 0, 0, 800, 480)
        ewmh.display.flush()

    def xgatea2(self):
        global moveA2
        moveA2 = 1
    
    def idgatea2(self):
        global moveA2
        moveA2 = 0
    
    def hgatea2(self):
        global moveA2
        moveA2 = 2
    
class CoinGameScreenResults(Screen):
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
    # var for result text
    winnert = StringProperty("")
    superpositiont = StringProperty("")
    propAt = StringProperty("")
    propBt = StringProperty("")
    countst = StringProperty("")

    # images for coinr esults
    heads = "./Images/Coin-25-0-0-Kopf.png"
    heads_twist = "./Images/Coin-25-180-0-Kopf-gedreht.png"
    superpos = "./Images/Coin-115-0-0-Kante.png"
    tails = "./Images/Coin-25-180-180-Zahl.png"
    superpos_twist = "./Images/Coin-115-180-0-Kante-gedreht.png"
    superpos_tails = "./Images/Coin-Zahl-Kante.png"

    # all possible coin game outcomes
    images_map = {
        "000": [heads, heads, heads], 
        "001": [heads, heads, tails], 
        "010": [heads, tails, tails], 
        "011": [heads, tails, heads], 
        "100": [tails, tails, tails],
        "101": [tails, tails, heads], 
        "110": [tails, heads, heads],
        "111": [tails, heads, tails],
        "200": [superpos, superpos, superpos],
        "201": [superpos, superpos, superpos_twist],
        "210": [superpos, superpos_twist, superpos_twist],
        "211": [superpos, superpos_twist, superpos],
        "202": [superpos, superpos, heads],
        "212": [superpos, superpos_twist, heads_twist],
        "002": [heads, heads, superpos],
        "102": [tails, tails, superpos_tails],
        "012": [heads, tails, superpos_tails],
        "112": [tails, heads, superpos]
        }

    # var for the for coins in the result screen
    coin1 = StringProperty("")
    coin2 = StringProperty("")
    coin3 = StringProperty("")
    coin4 = StringProperty("")

    def build(self):
        return RootScreen()

    def on_start(self):
        global win
        win = ewmh.getActiveWindow()
        ewmh.setWmState(win, 1, '_NET_WM_STATE_ABOVE')
        ewmh.display.flush()

    # auxillary function to identify the winner
    def who_wins(self, counts):
        if len(counts)==1 :
            winner = 'A' if ("0" in counts) else 'B'
            self.winnert = 'The winner is %s' % winner
            self.propAt = ""
            self.propBt = ""
            self.superpositiont = ""
        else:
            self.winnert = ""
            count0=counts["0"]
            count1=counts["1"]
            superposition = 'The coin is in superposition of |0⟩ and |1⟩'
            self.superpositiont = superposition
            A = (100.*count0/(count0+count1))
            propA = "%.1f%%" % A
            self.propAt = 'A wins with probability %s' % propA
            B = (100.*count1/(count0+count1))
            propB = "%.1f%%" % B
            self.propBt = 'B wins with probability %s' % propB
        return()

    def run_game(self):
        # create the quantum circuit with the chosen coin moves
        q = QuantumRegister(1) # create a quantum register with one qubit
        # create a classical register that will hold the results of the measurement
        c = ClassicalRegister(1) 
        qc = QuantumCircuit(q, c) # creates the quantum circuit
        backend = BasicAer.get_backend('qasm_simulator') # define the backend

        # 1. move of A
        if   moveA1 == 0 : 
            qc.id(q[0])
        elif moveA1 == 1 : 
            qc.x(q[0]) 
        elif moveA1 == 2 : 
            qc.h(q[0]) 
            
        # 1. move of B 
        if   moveB1 == 0 : 
            qc.id(q[0])
        elif moveB1 == 1 : 
            qc.x(q[0])     

        # 2. move of A
        if   moveA2 == 0 : 
            qc.id(q[0])
        elif moveA2 == 1 : 
            qc.x(q[0]) 
        elif moveA2 == 2 : 
            qc.h(q[0]) 

        qc.measure(q, c) # Measure the qubits

        # execute the quantum circiut (coin moves) and identify the winner
        # run the job simulation
        job = execute(qc, backend, shots=200) 
        # grab the result
        result = job.result() 
        # results for the number of runs
        counts = result.get_counts(qc)
        self.countst = str(counts) 
        # celebrate the winner
        self.who_wins(counts); 

        # get the images for the result screen, dependent from the moves
        move = str(moveA1) + str(moveB1) + str(moveA2)
        coins = self.images_map.get(move)

        self.coin1 = self.heads
        self.coin2 = coins[0]
        self.coin3 = coins[1]
        self.coin4 = coins[2]
        
# run
if __name__ == "__main__":
    Main().run()
