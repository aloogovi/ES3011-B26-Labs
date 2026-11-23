% This script is written for Lab 5 of ES3011 B26 by 
% Aditi Bhattamishra, Kate Stahler, and Yael Whitson (Team 13).
% The script is adapted using a demo script previously provided. 
% Due 11/25/2026

clear; clc;

% Set time array variables for all simulations
T = 120; %simulation time [s]
dt = 0.05; %time step [s]
t = 0:dt:T; %time array [t]

%% Mass-Spring-Damper System (Q1)

% Create system properties and constants variables
m = 5; %mass [Kg]
k = 1.0; %spring constant [N/m]
b = 0.5; %damping constant [N*s/m]
F = 2; %input force [N]

u = F*ones(size(t));

% Create transfer function
num = 1; %numerator
denom = [m b k]; %denominator
sys = tf(num, denom); %create transfer function

%Run step response sim
[y_step, t_step] = step(sys, t, Amplitude=F);
transient = stepinfo(y_step, t_step, 'SettlingTimeThreshold', 0.02, 'RiseTimeLimits', [0 1]); %collect transient response info

%Run ramp response sim
y_ramp = lsim(sys, u, t);

%Run impulse response sim
[y_imp, t_imp] = impulse(sys, t, Amplitude=F); %impulse response

% Create figure with all three plots 
figure;
tiledlayout(2,2);

nexttile;
plot(t, y_ramp, 'b', 'LineWidth', 1.5); %plot ramp response
title("Mass-Spring-Damper System: Ramp Response w/ F=2N");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_imp, y_imp, 'b', 'LineWidth', 1.5); %plot impulse response
title("Mass-Spring-Damper System: Impulse Response w/ F=2N");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_step, y_step, 'b', 'LineWidth', 1.5); %plot step response 
hold on;
plot(transient.PeakTime, transient.Peak, 'Marker', 'square', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'Color', 'r'); %plot peak time + peak value which is final value + overshoot
xline(transient.RiseTime, "Color", 'g', 'LineStyle', '--', 'LineWidth', 1.5); %plot rise time as a vertical line
xline(transient.SettlingTime, "Color", 'm', 'LineStyle', '--', 'LineWidth', 1.5); %plot settling time as a vertical line
title("Mass-Spring-Damper System: Step Response w/ F=2N and Transient Variables Shown");
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
c = 300 * 10^(-6); %capacitance [F]
R = 100; %resistance [ohm]
V = 300; %input voltage [V]

u = V*ones(size(t));

% Create transfer function
num = 1; %numerator
denom = [L R 1/c]; %denominator
sys = tf(num, denom); %create transfer function

%Run step response sim
[y_step, t_step] = step(sys, t, Amplitude=V);
transient = stepinfo(y_step, t_step, 'SettlingTimeThreshold', 0.02, 'RiseTimeLimits', [0 1]); %collect transient response info

%Run ramp response sim
y_ramp = lsim(sys, u, t);

%Run impulse response sim
[y_imp, t_imp] = impulse(sys, t, Amplitude=V); %impulse response

% Create figure with all three plots 
figure;
tiledlayout(2,2);

nexttile;
plot(t, y_ramp, 'b', 'LineWidth', 1.5); %plot ramp response
title("RLC Circuit: Ramp Response w/ V=300V");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_imp, y_imp, 'b', 'LineWidth', 1.5); %plot impulse response
title("RLC Circuit: Impulse Response w/ V=300V");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_step, y_step, 'b', 'LineWidth', 1.5); %plot step response 
hold on;
plot(transient.PeakTime, transient.Peak, 'Marker', 'square', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'Color', 'r'); %plot peak time + peak value which is final value + overshoot
xline(transient.RiseTime, "Color", 'g', 'LineStyle', '--', 'LineWidth', 1.5); %plot rise time as a vertical line
xline(transient.SettlingTime, "Color", 'm', 'LineStyle', '--', 'LineWidth', 1.5); %plot settling time as a vertical line
title("RLC Circuit: Step Response w/ V=300V and Transient Variables Shown");
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

u = U*ones(size(t));

% Create transfer function
num = 1; %numerator
denom = [m b]; %denominator
sys = tf(num, denom); %create transfer function

%Run step response sim
[y_step, t_step] = step(sys, t, Amplitude=U);
transient = stepinfo(y_step, t_step, 'SettlingTimeThreshold', 0.02, 'RiseTimeLimits', [0 1]); %collect transient response info

%Run ramp response sim
y_ramp = lsim(sys, u, t);

%Run impulse response sim
[y_imp, t_imp] = impulse(sys, t, Amplitude=U); %impulse response

% Create figure with all three plots 
figure;
tiledlayout(2,2);

nexttile;
plot(t, y_ramp, 'b', 'LineWidth', 1.5); %plot ramp response
title("Car Cruise-Control: Ramp Response w/ U=1500N");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_imp, y_imp, 'b', 'LineWidth', 1.5); %plot impulse response
title("Car Cruise-Control: Impulse Response w/ U=1500N");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_step, y_step, 'b', 'LineWidth', 1.5); %plot step response 
hold on;
plot(transient.PeakTime, transient.Peak, 'Marker', 'square', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'Color', 'r'); %plot peak time + peak value which is final value + overshoot
xline(transient.RiseTime, "Color", 'g', 'LineStyle', '--', 'LineWidth', 1.5); %plot rise time as a vertical line
xline(transient.SettlingTime, "Color", 'm', 'LineStyle', '--', 'LineWidth', 1.5); %plot settling time as a vertical line
title("Car Cruise-Control: Step Response w/ U=1500N and Transient Variables Shown");
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

u = V*ones(size(t));

% Create transfer function
num = k; %numerator
denom = [J*L (J*R+L*b) (R*b + K^2) 0]; %denominator
sys = tf(num, denom); %create transfer function

%Run step response sim
[y_step, t_step] = step(sys, t, Amplitude=V);
transient = stepinfo(y_step, t_step, 'SettlingTimeThreshold', 0.02, 'RiseTimeLimits', [0 1]); %collect transient response info

%Run ramp response sim
y_ramp = lsim(sys, u, t);

%Run impulse response sim
[y_imp, t_imp] = impulse(sys, t, Amplitude=V); %impulse response

% Create figure with all three plots 
figure;
tiledlayout(2,2);

nexttile;
plot(t, y_ramp, 'b', 'LineWidth', 1.5); %plot ramp response
title("Motor Position: Ramp Response w/ V=100V");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_imp, y_imp, 'b', 'LineWidth', 1.5); %plot impulse response
title("Motor Position: Impulse Response w/ V=100V");
xlabel("Time (s)");
ylabel("Amplitude y(t)");
grid on;

nexttile;
plot(t_step, y_step, 'b', 'LineWidth', 1.5); %plot step response 
hold on;
plot(transient.PeakTime, transient.Peak, 'Marker', 'square', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'Color', 'r'); %plot peak time + peak value which is final value + overshoot
xline(transient.RiseTime, "Color", 'g', 'LineStyle', '--', 'LineWidth', 1.5); %plot rise time as a vertical line
xline(transient.SettlingTime, "Color", 'm', 'LineStyle', '--', 'LineWidth', 1.5); %plot settling time as a vertical line
title("Motor Position: Step Response w/ V=100V and Transient Variables Shown");
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