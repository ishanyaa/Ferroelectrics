% PMOS Capacitor Parameters
Vg = 2;          % Gate voltage
Vth = -0.5;      % Threshold voltage (negative for PMOS)
Vfb = -0.7;      % Flat-band voltage
phiF = 0.7;      % Fermi potential

% Calculate surface potential for depletion and inversion
psi_depletion = Vg - Vth - Vfb;
psi_inversion = Vg - Vth;

% Distance from the surface (arbitrary units)
x = linspace(0, 1, 100);

% Oxide capacitance per unit area (arbitrary units)
Cox = 1;

% Electric field calculations
E_depletion = -1/Cox * diff([0, psi_depletion]) / (x(2) - x(1));
E_inversion = -1/Cox * diff([0, psi_inversion]) / (x(2) - x(1));

% Plotting
figure;
plot(x, E_depletion, 'r', 'LineWidth', 2, 'DisplayName', 'Depletion');
hold on;
plot(x, E_inversion, 'g', 'LineWidth', 2, 'DisplayName', 'Inversion');
xlabel('Distance from Surface');
ylabel('Electric Field (E)');
title('Electric Field Variation in PMOS Capacitor');
legend('Location', 'Best');
grid on;
hold off;
