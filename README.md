# AURA
Power Electronics Optimization Framework

## Description
The Switched Mode Power Supply Toolbox provides capabilities for the steady-state and small-signal modeling of switched mode power supplies.  These capabilities facilitate design optimization in power electronics for a variety of applications.  

The toolbox is designed to model power electronics in a manner that is 
- **A**ccurate: integrates nonlinear behaviors to result in non-idealized predictions of real-world performance
- **U**nified: can be applied to designs across topological, implementation, and operational barriers
- **R**apid: can be completed without the need for extensive computational resources or long simulation times
- **A**daptable: robust to varying levels of design data and applicable to varying physical implementations

## System Requirements
The toolbox is tested with MATLAB R2022b and after.  Known issues will occur with MATLAB versions prior to R2020b.  

## Installation
The latest build of the [packaged toolbox](https://github.com/costinet/AURA/releases/latest/download/Switched.Mode.Power.Supply.Toolbox.mltbx) from the repository.

Additional releases are available from the [Releases](https://github.com/costinet/AURA/releases) folder of the repository.  Drag and drop the mlbtx file into your matlab workspace to install.  To view the installed files, uninstall, or manage the installation of the toolbox, go to MATLAB Home->Add-Ons->Manage Add-Ons and find "Switched Mode Power Supply Toolbox" in your list of installed toolboxes.

### Updating Libraries

From the MATLAB command line, run `updateToolbox` to update both the toolbox code and associated libraries.  After the first installation, re-running this script will always allow you to update to the latest version of the toolbox and databases.

# Structure and Use

![](./state%20space%20analysis/doc/images/gettingStartedImages/ToolboxStructure.png)

## Documentation
For an introduction to the toolbox, see the [GettingStarted.mlx](https://github.com/costinet/AURA/blob/master/state%20space%20analysis/doc/GettingStarted.mlx) or the web-based version of the same file [GettingStarted.md](https://github.com/costinet/AURA/blob/master/GettingStarted.md)

For an example use case, see [SeriesCapBuck.mlx](https://github.com/costinet/AURA/blob/master/state%20space%20analysis/doc/examples/SeriesCapBuck/SweepSeriesCapBuck.mlx) or the web-based version of the same file [SeriesCapBuck.md](https://github.com/costinet/AURA/blob/master/state%20space%20analysis/doc/examples/SeriesCapBuck/SweepSeriesCapBuck.md)

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=costinet/AURA&project=state%20space%20analysis/Toolbox/AURA.prj&file=state%20space%20analysis/doc/GettingStarted.mlx)

# Licensing

The toolbox is available under the [MIT License](https://github.com/costinet/AURA/blob/master/LICENSE.txt)

# Attribution

If the framework provided in this toolbox is used in preparation of a published work in a manner warranting a citation, the following is the suggested reference format for the toolbox itself

J. A. Baxter and D. Costinett, Switched Mode Power Supply Toolbox, v0.2.x, https://github.com/costinet/AURA

\@electronic{SMPSToolbox,
  author        = "J. A. Baxter and D. Costinett",
  title         = "Switched Mode Power Supply Toolbox, v0.2.x",
  url           = "https://github.com/costinet/AURA",
  year          = "2023"
}

Select aspects of the framework are detailed in the following publicaitons

   1.  J. A. Baxter and D. J. Costinett, "Power Converter and Discrete Device Optimization Utilizing Discrete Time State-Space Modeling," 2023 IEEE 24th Workshop on Control and Modeling for Power Electronics (COMPEL), Ann Arbor, MI, USA, 2023, pp. 1-8, doi: 10.1109/COMPEL52896.2023.10221030. 
   1.  J. A. Baxter and D. J. Costinett, "Broad-Scale Converter Optimization Utilizing Discrete Time State-Space Modeling," 2022 IEEE Design Methodologies Conference (DMC), Bath, United Kingdom, 2022, pp. 1-6, doi: 10.1109/DMC55175.2022.9906473. 
   1.  J. A. Baxter and D. J. Costinett, "Steady-State Convergence of Discrete Time State-Space Modeling with State-Dependent Switching," 2020 IEEE 21st Workshop on Control and Modeling for Power Electronics (COMPEL), Aalborg, Denmark, 2020, pp. 1-8, doi: 10.1109/COMPEL49091.2020.9265734. 
   1.  J. A. Baxter and D. J. Costinett, "Converter Analysis Using Discrete Time State-Space Modeling," 2019 20th Workshop on Control and Modeling for Power Electronics (COMPEL), Toronto, ON, Canada, 2019, pp. 1-8, doi: 10.1109/COMPEL.2019.8769686. 

<!--
## SMPSim()
## Methods

### steadyState()
Finds periodic steady-state of the switched circuit without consideration of state-dependent switching actions (e.g. diodes)
### findValidSteadyState()
Iterates steady-state solution to find a valid solution considering state-dependent switching actions
### ssAvgs()
Returns the average values of all states and outputs over one period of the current steady-state solution
### plotAllStates()
Plots all states of the circuit over one period of the current steady-state solution
### plotAllOutputs()
Plots all outputs of the circuit over one period of the current steady-state solution
### SS_WF_Reconstruct()
Generates full waveforms with fine timestep for all states and outputs
### sigLoc()
Returns index into output, input, state, or switch vector for a specified signal name
### findSSTF()
(*experimental*) Finds small-signal transfer function from a specified time interval to all states at the end of the period



## Properties
### Xs 
Current steady-state solution e.g. as solved by SteadyState
### converter 
link to a SMPSconverter class object specifying the converter
### As 
3-dimensional matrix of values for Ai, where As(:,:,i) is the 2D square matrix Ai during the ith interval.
### Bs 
3-dimensional matrix of values for Bi, where Bs(:,:,i) is the 2D matrix/vector Bi during the ith interval.
### Cs 
3-dimensional matrix of values for Ci, where Cs(:,:,i) is the 2D square matrix Ci during the ith interval.  
### Ds 
3-dimensional matrix of values for Di, where Ds(:,:,i) is the 2D vector Di during the ith interval.
### Is 
3-dimensional matrix of values for Ii, where Is(:,:,i) is the 2D vector Ii during the ith interval.
### topology 
link to a SMPStopology class object specifying the converter topology
### stateNames 
Cell array with names of states ordered to correspond to their order in Xs
### outputNames 
Cell array with names of outputs ordered to correspond to their order in Y
### switchNames 
Cell array with names of switches ordered to correspond to their order in the SMPSconverter swvec
### inputNames  
Cell array with names of inputs ordered to correspond to their order in u
### ts 
ts is a vector of the time durations of each inverval
### u 
u is the (assumed constant within each interval) independent input vector
### swvec 
swvec is a matrix of binary switch states.  swvec(i,j) is the on/off status of switch i during time interval j
### Ys 
Outputs at current steady-state solution
### YsEnd 
Outputs at the end of each subinterval for current steady-state solution


## SMPSconverter()
## Methods
### setSwitchingPattern()
Sets the modulation pattern, consisting of both switching state of each switching element and the time duration of each interval

## Properties


## SMPStopology()
## Methods
### loadCircuit()

## Properties
### circuitParser
### constraints
### labels
### sourcefn


## AURAdb()
## Methods
### sync()

## Properties
### transistors
### inductors
Not yet implemented
### capacitors
Not yet implemented
### cores
Not yet implemented
### wires
Not yet implemented
### topologies
Not yet implemented

-->
