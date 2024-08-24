# https://raspberrypi.stackexchange.com/questions/85109/run-rpi-ws281x-without-sudo
# https://github.com/joosteto/ws2812-spi

# start with python3 RasQ-LED.py 

import subprocess, time, math
from dotenv import dotenv_values

config = dotenv_values("/home/pi/RasQberry/rasqberry_environment.env")
n_qbit = int(config["N_QUBIT"])
LED_COUNT = int(config["LED_COUNT"])
LED_PIN = int(config["LED_PIN"])

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


def set_up_circuit(factor):
    global circuit
    circuit = QuantumCircuit(qr, cr)

    if factor == 0:
      factor = n_qbit

    # relevant qubits are the first qubits in each subgroup
    relevant_qbit = 0

    for i in range(0, n_qbit):
        if (i % factor) == 0:
            circuit.h(qr[i])
            relevant_qbit = i
        else:
            circuit.cx(qr[relevant_qbit], qr[i])

    circuit.measure(qr, cr)

def get_factors(number):
    factor_list = []

    # search for factors, including factor 1 and n_qbit itself
    for i in range(1, math.ceil(number / 2) + 1):  
        if number % i == 0:
            factor_list.append(i)

    factor_list.append(n_qbit)
    return factor_list

def circ_execute():
  # execute the circuit
  job = execute(circuit, backend, shots=shots)
  result = job.result()
  counts = result.get_counts(circuit)
  global measurement
  measurement = list(counts.items())[0][0]
  print("measurement: ", measurement)

# alternative with statevector_simulator
# simulator = Aer.get_backend('statevector_simulator')
# result = execute(circuit, simulator).result()
# statevector = result.get_statevector(circuit)
# bin(statevector.tolist().index(1.+0.j))[2:]

def call_display_on_strip(measurement):
  subprocess.call(["sudo","python3","/home/pi/RasQberry/demos/bin/RasQ-LED-display.py", measurement])

# n is the size of the entangled blocks
def run_circ(n):
  init_circuit()
  if n == 1:
    print("build circuit without entanglement")
    set_up_circuit(1) 
  elif n == 0 or n == n_qbit:
    print("build circuit with complete entanglement")
    set_up_circuit(n_qbit)
  else:
    print("build circuit with entangled blocks of size " + str(n))
    set_up_circuit(n)
  circ_execute()
  call_display_on_strip(measurement)

def action():
    while True:
        #print(menu)
        player_action = input("select circuit to execute (1/2/3/q) ")
        if player_action == '1':
          run_circ(1) 
        elif player_action == '2':
          run_circ(n_qbit)
        elif player_action == "3":
            factors = get_factors(n_qbit)
            for factor in factors: 
              run_circ(factor)
              time.sleep(3)
        elif player_action == 'q':
          subprocess.call(["sudo","python3","/home/pi/RasQberry/demos/bin/RasQ-LED-display.py", "0", "-c"])
          quit()
        else:
            print("Please type \'1\', \'2\', \'3\' or \'q\'")

def loop(duration):
  print()
  print("RasQ-LED creates groups of entangled Qubits and displays the measurment result using colors of the LEDs.")
  print("A H(adamard) gate is applied to the first Qubit of each group; then CNOT gates to create entanglement of the whole group.")
  print("The size of the groups starts with 1, then in steps up to all Qubits.")
  print()
  for i in range(duration):
    factors = get_factors(n_qbit)
    for factor in factors: 
      run_circ(factor)
      time.sleep(3)
  subprocess.call(["sudo","python3","/home/pi/RasQberry/demos/bin/RasQ-LED-display.py", "0", "-c"])
  
loop(2)

#action()

