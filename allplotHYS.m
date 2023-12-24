% Parameters
a = 3.1024;
c = 0.7236;
Vc = 2.08677;
Vm = 10;

% Voltage ranges
V_range_10V = linspace(-Vm, Vm, 1000);
V_range_8V = linspace(-8, 8, 1000);
V_range_5V = linspace(-5, 5, 1000);

% Calculate Q for both branches for different voltages
Q1_10V = c / (2 * a) * (atan((Vm + Vc) / a) - atan((Vm - Vc) / a)) + (c / a) * atan((V_range_10V - Vc) / a);
Q2_10V = c / (2 * a) * (atan((Vm - Vc) / a) - atan((Vm + Vc) / a)) + (c / a) * atan((V_range_10V + Vc) / a);

Q1_8V = c / (2 * a) * (atan((8 + Vc) / a) - atan((8 - Vc) / a)) + (c / a) * atan((V_range_8V - Vc) / a);
Q2_8V = c / (2 * a) * (atan((8 - Vc) / a) - atan((8 + Vc) / a)) + (c / a) * atan((V_range_8V + Vc) / a);

Q1_5V = c / (2 * a) * (atan((5 + Vc) / a) - atan((5 - Vc) / a)) + (c / a) * atan((V_range_5V - Vc) / a);
Q2_5V = c / (2 * a) * (atan((5 - Vc) / a) - atan((5 + Vc) / a)) + (c / a) * atan((V_range_5V + Vc) / a);

% Calculate C for both branches for different voltages
C1_10V = c ./ (a^2 + (V_range_10V - Vc).^2);
C2_10V = c ./ (a^2 + (V_range_10V + Vc).^2);

C1_8V = c ./ (a^2 + (V_range_8V - Vc).^2);
C2_8V = c ./ (a^2 + (V_range_8V + Vc).^2);

C1_5V = c ./ (a^2 + (V_range_5V - Vc).^2);
C2_5V = c ./ (a^2 + (V_range_5V + Vc).^2);

% Plotting
figure;
yyaxis left;
plot(V_range_10V, Q1_10V, 'LineWidth', 2, 'DisplayName', 'Q1 (10V Lower Branch)');
hold on;
plot(V_range_10V, Q2_10V, 'LineWidth', 2, 'DisplayName', 'Q2 (10V Upper Branch)');
plot(V_range_8V, Q1_8V, '--', 'LineWidth', 2, 'DisplayName', 'Q1 (8V Lower Branch)');
plot(V_range_8V, Q2_8V, '--', 'LineWidth', 2, 'DisplayName', 'Q2 (8V Upper Branch)');
plot(V_range_5V, Q1_5V, '-.', 'LineWidth', 2, 'DisplayName', 'Q1 (5V Lower Branch)');
plot(V_range_5V, Q2_5V, '-.', 'LineWidth', 2, 'DisplayName', 'Q2 (5V Upper Branch)');
ylabel('Charge (Q)');

yyaxis right;
plot(V_range_10V, C1_10V, 'LineWidth', 2, 'DisplayName', 'C1 (10V Lower Branch)');
plot(V_range_10V, C2_10V, 'LineWidth', 2, 'DisplayName', 'C2 (10V Upper Branch)');
plot(V_range_8V, C1_8V, '--', 'LineWidth', 2, 'DisplayName', 'C1 (8V Lower Branch)');
plot(V_range_8V, C2_8V, '--', 'LineWidth', 2, 'DisplayName', 'C2 (8V Upper Branch)');
plot(V_range_5V, C1_5V, '-.', 'LineWidth', 2, 'DisplayName', 'C1 (5V Lower Branch)');
plot(V_range_5V, C2_5V, '-.', 'LineWidth', 2, 'DisplayName', 'C2 (5V Upper Branch)');
ylabel('Capacitance (C)');

xlabel('Voltage (V)');
title('Ferroelectric Capacitor Charge and Capacitance vs Voltage at Different Voltages');
legend('show');
grid on;
hold off;
