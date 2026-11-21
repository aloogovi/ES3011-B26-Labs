% This script is written for Lab 5 of ES3011 B26 by 
% Aditi Bhattamishra, Kate Stahler, and Yael Whitson (Team 13).
% The script is adapted using a demo script previously provided. 
% Due 11/25/2026

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

% Create transfer function
num = 1; %numerator
denom = [m b k]; %denominator
sys = tf(num, denom); %create transfer function

%Run step response sim
[y_step, t_step] = step(sys, t);
transient = stepinfo(F*y_step, t_step, 'SettlingTimeThreshold', 0.02, 'RiseTimeLimits', [0 1]); %collect transient response info

%Run ramp response sim
u_ramp = t;
y_ramp = lsim(sys, u_ramp, t);

%Run impulse response sim
[y_imp, t_imp] = impulse(sys, t); %impulse response

% Create figure with all three plots 
figure;
tiledlayout(2,2);

nexttile;
plot(t, F*y_ramp, 'b', 'LineWidth', 1.5); %plot ramp response
title("Mass-Spring-Damper System: Unit-Ramp Response");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_imp, F*y_imp, 'b', 'LineWidth', 1.5); %plot impulse response
title("Mass-Spring-Damper System: Unit-Impulse Response");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_step, F*y_step, 'b', 'LineWidth', 1.5); %plot step response 
hold on;
plot(transient.PeakTime, transient.Peak, 'Marker', 'square', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'Color', 'r'); %plot peak time + peak value which is final value + overshoot
xline(transient.RiseTime, "Color", 'g', 'LineStyle', '--', 'LineWidth', 1.5); %plot rise time as a vertical line
xline(transient.SettlingTime, "Color", 'm', 'LineStyle', '--', 'LineWidth', 1.5); %plot settling time as a vertical line
title("Mass-Spring-Damper System: Unit-Step Response w/ Transient Variables Shown");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
legend("Step Response", "Peak Point at Peak Time tP", "Rise Time tR", "Settling Time tS", 'Location', 'southeast');

nexttile;
axis([0 5 0 5]);
axis off;
transientProps = "Step Response Transient Properties (extracted from stepinfo)"+newline... 
                  +"2% Settling Time t_s (seconds): "+num2str(transient.SettlingTime)+newline...
                  +"Rise Time t_r (seconds): " + num2str(transient.RiseTime)+newline...
                  +"Peak Time t_p (seconds): " + num2str(transient.PeakTime)+newline...
                  +"Peak Value y(t_p): " + num2str(transient.Peak)+newline...
                  +"Max Overshoot M_p (%): " +num2str(transient.Overshoot);
text(1, 2, transientProps, ...
    'BackgroundColor', [1 1 1], ...
    'EdgeColor', [0 0 0]);
grid on;
hold off;

%% RLC Circuit (Q2)

% Create system properties and constants variables
L = 5; %inductance [H]
c = 300; %capacitance [F]
R = 100000; %resistance [ohm]
V = 300; %input voltage [V]

% Set time array variables
T = 10; %simulation time [s]
dt = 0.05; %time step [s]
t = 0:dt:T; %time array [t]

% Create transfer function
num = 1; %numerator
denom = [L R 1/c]; %denominator
sys = tf(num, denom); %create transfer function

%Run step response sim
[y_step, t_step] = step(sys, t);
transient = stepinfo(V*y_step, t_step, 'SettlingTimeThreshold', 0.02, 'RiseTimeLimits', [0 1]); %collect transient response info

%Run ramp response sim
u_ramp = t;
y_ramp = lsim(sys, u_ramp, t);

%Run impulse response sim
[y_imp, t_imp] = impulse(sys, t); %impulse response

% Create figure with all three plots 
figure;
tiledlayout(2,2);

nexttile;
plot(t, V*y_ramp, 'b', 'LineWidth', 1.5); %plot ramp response
title("RLC Circuit: Unit-Ramp Response");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_imp, V*y_imp, 'b', 'LineWidth', 1.5); %plot impulse response
title("RLC Circuit: Unit-Impulse Response");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_step, V*y_step, 'b', 'LineWidth', 1.5); %plot step response 
hold on;
plot(transient.PeakTime, transient.Peak, 'Marker', 'square', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'Color', 'r'); %plot peak time + peak value which is final value + overshoot
xline(transient.RiseTime, "Color", 'g', 'LineStyle', '--', 'LineWidth', 1.5); %plot rise time as a vertical line
xline(transient.SettlingTime, "Color", 'm', 'LineStyle', '--', 'LineWidth', 1.5); %plot settling time as a vertical line
title("RLC Circuit: Unit-Step Response w/ Transient Variables Shown");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
legend("Step Response", "Peak Point at Peak Time tP", "Rise Time tR", "Settling Time tS", 'Location', 'southeast');

nexttile;
axis([0 5 0 5]);
axis off;
transientProps = "Step Response Transient Properties (extracted from stepinfo)"+newline... 
                  +"2% Settling Time t_s (seconds): "+num2str(transient.SettlingTime)+newline...
                  +"Rise Time t_r (seconds): " + num2str(transient.RiseTime)+newline...
                  +"Peak Time t_p (seconds): " + num2str(transient.PeakTime)+newline...
                  +"Peak Value y(t_p): " + num2str(transient.Peak)+newline...
                  +"Max Overshoot M_p (%): " +num2str(transient.Overshoot);
text(1, 2, transientProps, ...
    'BackgroundColor', [1 1 1], ...
    'EdgeColor', [0 0 0]);
grid on;
hold off;

%% Cruise-Control Car (Q3)

% Create system properties and constants variables
m = 1500; %vehicle mass [kg]
b = 50; %damping coefficient [N*s/m]
U = 1500; %input force [N]

% Set time array variables
T = 100; %simulation time [s]
dt = 0.05; %time step [s]
t = 0:dt:T; %time array [t]

% Create transfer function
num = 1; %numerator
denom = [m b]; %denominator
sys = tf(num, denom); %create transfer function

%Run step response sim
[y_step, t_step] = step(sys, t);
transient = stepinfo(U*y_step, t_step, 'SettlingTimeThreshold', 0.02, 'RiseTimeLimits', [0 1]); %collect transient response info

%Run ramp response sim
u_ramp = t;
y_ramp = lsim(sys, u_ramp, t);

%Run impulse response sim
[y_imp, t_imp] = impulse(sys, t); %impulse response

% Create figure with all three plots 
figure;
tiledlayout(2,2);

nexttile;
plot(t, U*y_ramp, 'b', 'LineWidth', 1.5); %plot ramp response
title("Car Cruise-Control: Unit-Ramp Response");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_imp, U*y_imp, 'b', 'LineWidth', 1.5); %plot impulse response
title("Car Cruise-Control: Unit-Impulse Response");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_step, U*y_step, 'b', 'LineWidth', 1.5); %plot step response 
hold on;
plot(transient.PeakTime, transient.Peak, 'Marker', 'square', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'Color', 'r'); %plot peak time + peak value which is final value + overshoot
xline(transient.RiseTime, "Color", 'g', 'LineStyle', '--', 'LineWidth', 1.5); %plot rise time as a vertical line
xline(transient.SettlingTime, "Color", 'm', 'LineStyle', '--', 'LineWidth', 1.5); %plot settling time as a vertical line
title("Car Cruise-Control: Unit-Step Response w/ Transient Variables Shown");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
legend("Step Response", "Peak Point at Peak Time tP", "Rise Time tR", "Settling Time tS", 'Location', 'southeast');

nexttile;
axis([0 5 0 5]);
axis off;
transientProps = "Step Response Transient Properties (extracted from stepinfo)"+newline... 
                  +"2% Settling Time t_s (seconds): "+num2str(transient.SettlingTime)+newline...
                  +"Rise Time t_r (seconds): " + num2str(transient.RiseTime)+newline...
                  +"Peak Time t_p (seconds): " + num2str(transient.PeakTime)+newline...
                  +"Peak Value y(t_p): " + num2str(transient.Peak)+newline...
                  +"Max Overshoot M_p (%): " +num2str(transient.Overshoot);
text(1, 2, transientProps, ...
    'BackgroundColor', [1 1 1], ...
    'EdgeColor', [0 0 0]);
grid on;
hold off;

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

% Create transfer function
num = k; %numerator
denom = [J*L (J*R+L*b) (R*b + K^2) 0]; %denominator
sys = tf(num, denom); %create transfer function

%Run step response sim
[y_step, t_step] = step(sys, t);
transient = stepinfo(V*y_step, t_step, 'SettlingTimeThreshold', 0.02, 'RiseTimeLimits', [0 1]); %collect transient response info

%Run ramp response sim
u_ramp = t;
y_ramp = lsim(sys, u_ramp, t);

%Run impulse response sim
[y_imp, t_imp] = impulse(sys, t); %impulse response

% Create figure with all three plots 
figure;
tiledlayout(2,2);

nexttile;
plot(t, V*y_ramp, 'b', 'LineWidth', 1.5); %plot ramp response
title("Motor Position: Unit-Ramp Response");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_imp, V*y_imp, 'b', 'LineWidth', 1.5); %plot impulse response
title("Motor Position: Unit-Impulse Response");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_step, V*y_step, 'b', 'LineWidth', 1.5); %plot step response 
hold on;
plot(transient.PeakTime, transient.Peak, 'Marker', 'square', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'Color', 'r'); %plot peak time + peak value which is final value + overshoot
xline(transient.RiseTime, "Color", 'g', 'LineStyle', '--', 'LineWidth', 1.5); %plot rise time as a vertical line
xline(transient.SettlingTime, "Color", 'm', 'LineStyle', '--', 'LineWidth', 1.5); %plot settling time as a vertical line
title("Motor Position: Unit-Step Response w/ Transient Variables Shown");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
legend("Step Response", "Peak Point at Peak Time tP", "Rise Time tR", "Settling Time tS", 'Location', 'southeast');

nexttile;
axis([0 5 0 5]);
axis off;
transientProps = "Step Response Transient Properties (extracted from stepinfo)"+newline... 
                  +"2% Settling Time t_s (seconds): "+num2str(transient.SettlingTime)+newline...
                  +"Rise Time t_r (seconds): " + num2str(transient.RiseTime)+newline...
                  +"Peak Time t_p (seconds): " + num2str(transient.PeakTime)+newline...
                  +"Peak Value y(t_p): " + num2str(transient.Peak)+newline...
                  +"Max Overshoot M_p (%): " +num2str(transient.Overshoot);
text(1, 2, transientProps, ...
    'BackgroundColor', [1 1 1], ...
    'EdgeColor', [0 0 0]);
grid on;
hold off;