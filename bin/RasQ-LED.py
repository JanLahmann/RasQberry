# https://raspberrypi.stackexchange.com/questions/85109/run-rpi-ws281x-without-sudo
# https://github.com/joosteto/ws2812-spi

# start with  rasqbery; python RasQ-LED.py 

import subprocess

n_qbit = 30

#Import Qiskit classes
from qiskit import IBMQ, execute
from qiskit import Aer 
from qiskit import QuantumCircuit, ClassicalRegister, QuantumRegister

# set the backend
backend = Aer.get_backend('qasm_simulator')
                
#Set number of shots
shots = 1

def init_circuit():
  # Create a Quantum Register with n qubits
  global qr
  qr = QuantumRegister(n_qbit)
  # Create a Classical Register with n bits
  global cr
  cr = ClassicalRegister(n_qbit)
  # Create a Quantum Circuit acting on the qr and cr register
  global circuit
  circuit = QuantumCircuit(qr, cr)
  global counts
  counts = {}
  global measurement
  measurement = ""

def circuit1():
  # Add gates to the circuit, equal superposition
  circuit.h(qr)
  circuit.measure(qr, cr)

def circuit2():
  # Add gates to the circuit, highly entangled state
  circuit.h(qr[0])
  for i in range(1,n_qbit):
    circuit.cx(qr[0], qr[i])
  circuit.measure(qr, cr)

def circ_execute():
  # execute the circuit
  job = execute(circuit, backend, shots=shots)
  result = job.result()
  counts = result.get_counts(circuit)
  global measurement
  measurement = list(counts.items())[0][0]
  print("measurement: ", measurement)

# alternative with staevector_simulator
# simulator = Aer.get_backend('statevector_simulator')
# result = execute(circuit, simulator).result()
# statevector = result.get_statevector(circuit)
# bin(statevector.tolist().index(1.+0.j))[2:]

def call_display_on_strip(measurement):
  subprocess.call(["sudo","python3","RasQ-LED-display.py", measurement])

def run_circ(n):
  init_circuit()
  if n == 1:
    print("build circuit 1")
    circuit1() 
  else:
    print("build circuit 2")
    circuit2()
  circ_execute()
  call_display_on_strip(measurement)

def action():
    while True:
        #print(menu)
        player_action = input("select circuit to execute (1/2/q) ")
        if player_action == '1':
          run_circ(1) 
        elif player_action == '2':
          run_circ(2)
        elif player_action == 'q':
          subprocess.call(["sudo","python3","RasQ-LED-display.py", "0", "-c"])
          quit()
        else:
            print("Please type \'1\' or \'2\'")

action()
