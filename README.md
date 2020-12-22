ECE4784
=======

Modeling Projects

Xurong Liu
Project 1 Report


a.)	
     A bio-electrical system can be modelled after an electric circuit because many components function similarly and can be simplified, through assumptions, to the commonly analyzed parts of a circuit. The membrane of the cell has often been the subject of many models as it is one of the most fundamentally important contributors in allowing life to exist. The membrane allows the cell to maintain unique concentrations internally that is different from fluid concentrations external from the cell and allows for the occurrence of electrical signal propagation between neurons called an action potential. This phenomenon is modelled as a circuit through the famous Hodgkin-Huxley Model which simplifies the complex biological processes into their corresponding electrical effects.
     The model represents the membrane of the cell as a capacitor because it has the ability to store charge. The membrane is a phospholipid bilayer that can be assumed to prevent charges from crossing and as a result, act as an insulator between two electrically conducting regions (cytoplasm and extracellular fluid). This allows the membrane to maintain a potential difference and thus positive and negative charges align on opposite sides of the plate just as in a capacitor. The electrochemical gradient between the ions inside and outside of the cell is represented as a voltage source because the large difference in gradients cause a driving force for current to travel. The voltage-gated channels for the ions are represented as a resistor (conductor) that varies depending on the amount of current injected into the cell. These channels are closed until a specific voltage threshold is reached and then open for a time to allow large influxes or effluxes of ions to propagate action potentials. Finally, the sodium/potassium ion pump is modelled as a current source because of its functionality of pumping 3 sodium ions out and 2 potassium ions into the cell, creating a conventional current out of the cell.


b.)	
https://github.com/xliu738/Neuron-Potential-Simulation.git


c.)	
•	The program was coded as a function in matlab (v7.7.0) released in September 2008. 
•	The function is called NeuronSim and can be ran directly from the Matlab Command Window by typing in “NeuronSim” and pressing enter.
•	Type “1” to run first simulation, two figures should appear.
•	Type “2” to run second simulation, the two figures from part 1 should update themselves.
•	Type “3” to run third simulation, again the figures should update.
•	Type “0” or other number to exit.



d.)	
Questions to answer:

a.	The neuron is at steady state and the membrane potential remains at -70mV and is maintained by the ion pumps and the diffusion channels throughout the membrane. At this point the potassium and sodium conductance remain constant throughout since there is no voltage change to change the channel gating.

b.	The current is injected 0.5ms after the start of the simulation and lasts for only 0.5ms. The overall membrane potential shows a slight change and becomes slightly less negative during the pulse stimulation. This is due to the current injection changing the voltage of the membrane slightly and thus changed the conductance of sodium and potassium channels for a short time. However, because the voltage change was not enough to cross a threshold, the cascade did not fully activate and returned to steady state shortly after the injected pulse subsided. It can be seen in the conductance graph that the sodium conductance increased slightly in response to the voltage injection to attempt to start the action potential but potassium conductance increased more and removed the excess charges before the threshold could be reached.

c.	The current injection lasts for 100ms this time and as a result, causes the voltage to cross the threshold and causes the action potential to fire. As seen from the conductance graph, the sodium conductance dramatically increased to allow depolarization and soon after, the potassium conductance reached a peak to allow for hyperpolarization and over-polarization before a repolarization to steady state. Though the current injection is persistent, the neuron is now in a refractory period and the ion channels will not reactivate for the rest of the simulation. The current injection is seen to alter the membrane voltage slightly however but will not cause the cell to cross over the threshold again until the refractory period is over.

d.	The most difficult part of the model was figuring out what the equations given represented and how the variables correlated with the concepts learned during lecture. Once the meaning of the equations were understood, the coding and graphing was very intuitive and quick. The main modeling concept reviewed during this project was hysteresis of a discrete system of equations. This entails that the equations modeling the action potentials depend on their previous state and exhibit a form of “memory” in addition to the dependence on an input or external stimuli.
