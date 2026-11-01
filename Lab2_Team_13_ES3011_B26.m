% This script is written for Lab 2 of ES3011 B26 by 
% Aditi Bhattamishra, Kate Stahler, and Yael Whitson (Team 13).
% The script is adapted using a demo script provided. 
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
plot (x1, y1);
title("Exercise 1: Mass-Spring-Damper System");
xlabel("Time (seconds)");
ylabel("Position (m)");

%% RLC Circuit (Q2)

% Create system properties and constants variables
L = 5; %inductance [H]
c = 300; %capacitance [F]
R = 100; %resistance [Kohm]
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
u = F*ones(size(t));

% Run simulation
[y2, x2] = lsim(sys,u,t);

% Make figure
figure;
plot (x2, y2);
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
A = []; %fill in and delete this comment after
B = []; %fill in and delete this comment after
C = []; %fill in and delete this comment after
D = []; %fill in and delete this comment after
sys = ss(A,B,C,D);

% Set input array
u = F*ones(size(t));

% Run simulation
[y3, x3] = lsim(sys,u,t);

% Make figure
figure;
plot (x3, y3);
title("Exercise 3: Cruise-Control Car");
xlabel("Time (seconds)");
ylabel(""); %fill in and delete this comment after

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
A = []; %fill in and delete this comment after
B = []; %fill in and delete this comment after
C = []; %fill in and delete this comment after
D = []; %fill in and delete this comment after
sys = ss(A,B,C,D);

% Set input array
u = F*ones(size(t));

% Run simulation
[y4, x4] = lsim(sys,u,t);

% Make figure
figure;
plot (x4, y4);
title("Exercise 4: Motor Position");
xlabel("Time (seconds)");
ylabel(""); %fill in and delete this comment after