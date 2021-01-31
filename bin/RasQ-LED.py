# https://raspberrypi.stackexchange.com/questions/85109/run-rpi-ws281x-without-sudo
# https://github.com/joosteto/ws2812-spi

# start with  rasqbery; python RasQ-LED.py 

import subprocess, time, math

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
  global circuit
  circuit = QuantumCircuit(qr, cr)

  # Add gates to the circuit, equal superposition
  circuit.h(qr)
  circuit.measure(qr, cr)

def circuit2():
  global circuit
  circuit = QuantumCircuit(qr, cr)

  # Add gates to the circuit, highly entangled state
  circuit.h(qr[0])
  for i in range(1,n_qbit):
    circuit.cx(qr[0], qr[i])
  circuit.measure(qr, cr)

def circuit3(factor):
    global circuit
    circuit = QuantumCircuit(qr, cr)

    # relevant qubits are the first qubits in each subgroup
    relevant_qbit = 0

    for i in range(0, n_qbit):
        if (i % (n_qbit / factor)) == 0:
            circuit.h(qr[i])
            relevant_qbit = i
        else:
            circuit.cx(qr[relevant_qbit], qr[i])

    circuit.measure(qr, cr)
    circ_execute()
    call_display_on_strip(measurement)

def get_factors(number):
    factor_list = []

    # search for factors
    # this excludes factor 1 and n_qbit itself, since we got those covered in circuit 1 & 2
    for i in range(2, math.ceil(number / 2) + 1):  
        if number % i == 0:
            factor_list.append(i)
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
  subprocess.call(["sudo","python3","/home/pi/.local/bin/RasQ-LED-display.py", measurement])

def run_circ(n):
  init_circuit()
  if n == 1:
    print("build circuit 1")
    circuit1() 
  elif n == 2:
    print("build circuit 2")
    circuit2()
  else:
    print("build circuit 3")
    factors = get_factors(n_qbit)  # or specific list of factors
    for factor in factors:
        circuit3(factor)
    return
  circ_execute()
  call_display_on_strip(measurement)

def action():
    while True:
        #print(menu)
        player_action = input("select circuit to execute (1/2/3/q) ")
        if player_action == '1':
          run_circ(1) 
        elif player_action == '2':
          run_circ(2)
        elif player_action == "3":
            run_circ(3)
        elif player_action == 'q':
          subprocess.call(["sudo","python3","/home/pi/.local/bin/RasQ-LED-display.py", "0", "-c"])
          quit()
        else:
            print("Please type \'1\', \'2\', \'3\' or \'q\'")

def loop(duration):
  for i in range(duration):
    run_circ(1)
    time.sleep(3)
    run_circ(2)
    time.sleep(3)
    run_circ(3)
    time.sleep(3)
  subprocess.call(["sudo","python3","/home/pi/.local/bin/RasQ-LED-display.py", "0", "-c"])
  
loop(5)

#action()

