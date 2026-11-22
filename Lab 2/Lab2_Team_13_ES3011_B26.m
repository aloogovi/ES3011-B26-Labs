% This script is written for Lab 2 of ES3011 B26 by 
% Aditi Bhattamishra, Kate Stahler, and Yael Whitson (Team 13).
% The script is adapted using a demo script previously provided. 
% Due 11/4/2026

clear; clc;

%% Mass-Springer-Damper System (Q1)

% Create system properties and constants variables
m = 5; %mass [Kg]
k = 1.0; %spring constant [N/m]
b = 0.5; %damping constant [N*s/m]
F = 2; %input force [N]

% Set time array variables
T = 20; %simulation time [s]
dt = 0.05; %time step [s]
t = 0:dt:T; %time array [t]

% Create state space equation coefficient variables
A = [0 1;
     -k/m -b/m];
B = [0; 1/m];
C = [1 0];
D = 0;
sys = ss(A,B,C,D);

% Set input array
u = F*ones(size(t));

% Run simulation
[y1, x1] = lsim(sys,u,t);

% Make figure (we do this manually to create four separate plots without
% overwriting)
figure;
subplot(2, 2, 1);
plot (x1, y1);
title("Exercise 1: Mass-Spring-Damper System");
xlabel("Time (seconds)");
ylabel("Position (m)");

%% RLC Circuit (Q2)

% Create system properties and constants variables
L = 5; %inductance [H]
c = 300; %capacitance [F]
R = 100000; %resistance [Kohm]
V = 300; %input voltage [V]

% Set time array variables
T = 10; %simulation time [s]
dt = 0.05; %time step [s]
t = 0:dt:T; %time array [t]

% Create state space equation coefficient variables
A = [0 1;
    -1/(L*c) -R/L];
B = [0; 1/L];
C = [0 1];
D = 0;
sys = ss(A,B,C,D);

% Set input array
u = V*ones(size(t));

% Run simulation
[y2, x2] = lsim(sys,u,t);

% Make figure
subplot(2, 2, 2);
plot (x2, y2);
axis([-0.1 10.2 0 3.2*10^(-3)])
title("Exercise 2: RLC Circuit");
xlabel("Time (seconds)");
ylabel("Current (A)");

%% Cruise-Control Car (Q3)

% Create system properties and constants variables
m = 1500; %vehicle mass [kg]
b = 50; %damping coefficient [N*s/m]
U = 1500; %input force [N]

% Set time array variables
T = 100; %simulation time [s]
dt = 0.05; %time step [s]
t = 0:dt:T; %time array [t]

% Create state space equation coefficient variables
A = [0 1;
    0 -b/m]; 
B = [0; 1/m]; 
C = [0 1];
D = 0;
sys = ss(A,B,C,D);

% Set input array
u = U*ones(size(t));

% Run simulation
[y3, x3] = lsim(sys,u,t);

% Make figure
subplot(2, 2, 3);
plot (x3, y3);
title("Exercise 3: Cruise-Control Car");
xlabel("Time (seconds)");
ylabel("Velocity (m/s)");

%% Motor Position (Q4)

% Create system properties and constants variables
J = 3*10^(-6); %rotor moment of inertia [kg*m^2]
b = 3.5*10^(-6); %motor friction coefficient [N*s/m]
K = 0.025; %electric force/motor torque coefficient [V/rad/sec]
R = 5; %resistance [Ohm]
L = 3*10^(-6); %inductance [H]
V = 100; %input voltage [V]

% Set time array variables
T = 10; %simulation time [s]
dt = 0.05; %time step [s]
t = 0:dt:T; %time array [t]

% Create state space equation coefficient variables
A = [0 1 0;
    0 -b/J K/J;
    0 -K/L -R/L]; %fill in and delete this comment after
B = [0;
    0;
    1/L]; %fill in and delete this comment after
C = [1 0 0]; %fill in and delete this comment after
D = 0; %fill in and delete this comment after
sys = ss(A,B,C,D);

% Set input array
u = V*ones(size(t));

% Run simulation
[y4, x4] = lsim(sys,u,t);

% Make figure
subplot(2, 2, 4);
plot (x4, y4);
title("Exercise 4: Motor Position");
xlabel("Time (seconds)");
ylabel("Rotational Position (radians)");