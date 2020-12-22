function NeuronSim

step = 0.001;
t = 0:step:100;
%   Determines the steps of the simulation and the time frame (0 to 100ms)

%   ----------------------------Constants----------------------------------
%   maximum conductances
gk_max = 36;
gna_max = 120;
gl_max = 0.3;
%   Nernst Potential of ions
Ek = -12;
Ena = 115;
El = 10.6;
%   Resting membrane voltage and membrane capacitance
V_rest = -70;
Cm = 1;     %   (microF/cm^2)

%   Loop to allow multiple simulations
while (true)

    %   Defines the vectors that will be used for Euler's First Approx.
    V = zeros(1, length(t));
    Vm = zeros(1, length(t));
    m = zeros(1, length(t));
    n = zeros(1, length(t));
    h = zeros(1, length(t));
    gna = zeros(1, length(t));
    gk = zeros(1, length(t));
    
    %   Switch Case statements to allow users to choose simulation to run
    options = input('Which simulation would you like to run?(1 = part1, 2 = part2 , 3 = part3, 0 to exit) :');
    switch (options)
        case 1
            I = zeros(1, length(t));    % I is 0 throughout
            graphTitle = 'Neuron with No Stimulation';
        case 2
            I = zeros(1, length(t));
            start = .5/step;            % Inject 0.5 ms after start
            pulse = .5/step;            % Pulse should last 0.5 ms
            I(start:start+pulse) = 5; 
            graphTitle = 'Neuron with 5uA/cm^2 Stimulation for 5 Seconds';
        case 3
            I = ones(1,length(t))*5;    % I is 5 microAmps throughout
            graphTitle = 'Neuron with 5uA/cm^2 Stimulation';
        otherwise
            break;
    end

    %   ----------------------------Parameters-----------------------------
    %   Sets membrane voltage to resting with no changes at start
    V(1) = V_rest;
    Vm(1) = 0;
    %   Constants used to calculate the change in conductances of channels
    alpha_m = 0.1*((25-Vm(1))/(exp((25-Vm(1))/10) - 1));
    beta_m = 4*exp(-Vm(1)/18);
    alpha_n = .01*((10-Vm(1))/(exp((10-Vm(1))/10) - 1));
    beta_n = .125*exp(-Vm(1)/80);
    alpha_h = .07*exp(-Vm(1)/20);
    beta_h = 1/(exp((30-Vm(1))/10) + 1);
    %   Initial Values for conductances
    m0 = alpha_m/(alpha_m + beta_m);
    n0 = alpha_n/(alpha_n + beta_n);
    h0 = alpha_h/(alpha_h + beta_h);
    m(1) = m0;
    n(1) = n0;
    h(1) = h0;
    %   Initial values for conductances
    gna(1) = (m(1)^3)*gna_max*(h(1));
    gk(1) = (n(1)^4)*gk_max;
    %   Initial changes set to zero since no changes yet 
    dm = 0;
    dn = 0;
    dh = 0;
    dVm = 0;

    %   Loop through for Euler's First Order Approximation
    %   The values of each variable is the value of the step before + change
    for i = 2:length(t)
        %   Calculate the variables in current step from changes 
        m(i) = m(i-1) + dm * step;
        n(i) = n(i-1) + dn * step;
        h(i) = h(i-1) + dh * step;
        Vm(i) = Vm(i-1) + dVm * step;
        V(i) = Vm(i) + V_rest;
        %   Find conductances from gating probabilities 
        gna(i) = (m(i)^3)*gna_max*(h(i));
        gk(i) = (n(i)^4)*gk_max;
        %   Calculate gating variables for next step
        alpha_m = 0.1*((25-Vm(i))/(exp((25-Vm(i))/10) - 1));
        beta_m = 4*exp(-Vm(i)/18);
        alpha_n = .01*((10-Vm(i))/(exp((10-Vm(i))/10) - 1));
        beta_n = .125*exp(-Vm(i)/80);
        alpha_h = .07*exp(-Vm(i)/20);
        beta_h = 1/(exp((30-Vm(i))/10) + 1);
        %   Calculate the currents from the conductances, voltage and
        %   nernst potential
        Ina = gna(i)*(Vm(i) - Ena);
        Ik = gk(i)*(Vm(i) - Ek);
        Il = gl_max*(Vm(i) - El);
        Iion = I(i) - Ina - Ik - Il;
        %   Calculate change in values for next step
        dVm = Iion/Cm;
        dm = alpha_m*(1-m(i)) - beta_m*m(i);
        dn = alpha_n*(1-n(i)) - beta_n*n(i);
        dh = alpha_h*(1-h(i)) - beta_h*h(i);
    end

    %   ----------------------------Results--------------------------------
    %   Plot Figures
    figure(1)
    plot(t(:),V(:));
    %   Scale axes
    axis([0 100 -100 100]);
    title(graphTitle);
    ylabel('Membrane Voltage (mV)');
    xlabel('Time (ms)');

    %   Make second figure to hold second plot
    figure(2)
    plot(t,gna,t,gk);
    %   Needs legend, titles and axis labels
    legend('gNa', 'gK');
    title('Sodium and Potassium Conductances');
    ylabel('Conductance (mS/cm^2)');
    xlabel('Time (ms)');
    
end

end