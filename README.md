# Electromagnetic Free-Fall Simulation with Damping  

A MATLAB project that simulates the motion of a falling object under the influence of gravity and an electromagnetic damping force.

This project was developed in **March 2023**.  

## Features  

- **Real-Time Animation**: Visualizes the falling object with dynamic position updates.  
- **Physics-Based Simulation**: Simulates free-fall motion with an electromagnetic damping force counteracting gravity.  
- **Runge-Kutta 4th Order (RK4) Method**: Numerically integrates motion equations for accurate trajectory calculation.  
- **Electromagnetic Resistance**: Implements a force proportional to velocity, slowing the object as it falls.  
- **Jerk Detection**: Computes and analyzes jerk (rate of change of acceleration) to check for sudden forces.  
- **Graphical Analysis**: Generates height-time, velocity-time, and acceleration-time plots.  

## Simulation

Here is an example of the simulation in action:

![simulation](https://github.com/user-attachments/assets/b997d74c-15bb-4406-8ff6-57a2581aa1b7)

## Graphs

Here is an example of the generated graphs:

![graphs](https://github.com/user-attachments/assets/f3e96382-398e-43b2-b68c-80eb03c073a2)

## Usage  

1. Open MATLAB and run the script `simulation.m`.  
2. Enter the required inputs (mass, initial height, and stopping height).  
3. The simulation will animate the object's motion and display real-time velocity.  
4. After the animation, plots of height, velocity, and acceleration over time will be generated. 

## Considerations  

- The **electromagnetic force** is implemented as a resistive force proportional to velocity, acting to **slow down the object**.  
- The `RK4` function is used to integrate the motion equations numerically.  
- The simulation assumes a uniform gravitational field.  
- The program checks for sudden changes in acceleration (jerk exceeding **100 m/s³**) and warns the user if this threshold is surpassed.
