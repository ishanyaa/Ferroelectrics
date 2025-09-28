% Parameters
Vdd = 5;          % Supply voltage
Vt_P = -1;        % PMOS threshold voltage
Vt_N = 1;         % NMOS threshold voltage
Vgs_min = -2;     % Minimum gate-source voltage
Vgs_max = 2;      % Maximum gate-source voltage
Vgs_step = 0.1;   % Voltage step for gate-source sweep

% PMOS in Enhancement Mode
Vgs_P_enhancement = Vgs_min:Vgs_step:Vgs_max;
Ids_P_enhancement = zeros(size(Vgs_P_enhancement));
for i = 1:length(Vgs_P_enhancement)
    Vgs = Vgs_P_enhancement(i);
    if Vgs < Vt_P
        Ids_P_enhancement(i) = 0;
    else
        Ids_P_enhancement(i) = -0.5*(Vgs - Vt_P)^2;
    end
end

% NMOS in Enhancement Mode
Vgs_N_enhancement = Vgs_min:Vgs_step:Vgs_max;
Ids_N_enhancement = zeros(size(Vgs_N_enhancement));
for i = 1:length(Vgs_N_enhancement)
    Vgs = Vgs_N_enhancement(i);
    if Vgs < Vt_N
        Ids_N_enhancement(i) = 0;
    else
        Ids_N_enhancement(i) = 0.5*(Vgs - Vt_N)^2;
    end
end

% PMOS in Depletion Mode
Vgs_P_depletion = Vgs_min:Vgs_step:Vgs_max;
Ids_P_depletion = zeros(size(Vgs_P_depletion));
for i = 1:length(Vgs_P_depletion)
    Vgs = Vgs_P_depletion(i);
    Ids_P_depletion(i) = -0.5*(Vgs - Vt_P)^2;
end

% NMOS in Depletion Mode
Vgs_N_depletion = Vgs_min:Vgs_step:Vgs_max;
Ids_N_depletion = zeros(size(Vgs_N_depletion));
for i = 1:length(Vgs_N_depletion)
    Vgs = Vgs_N_depletion(i);
    Ids_N_depletion(i) = 0.5*(Vgs - Vt_N)^2;
end

% Plot Transfer Characteristics
figure;
subplot(2, 2, 1);
plot(Vgs_P_enhancement, Ids_P_enhancement, 'r', 'LineWidth', 2);
hold on;
plot(Vgs_N_enhancement, Ids_N_enhancement, 'b', 'LineWidth', 2);
title('Transfer Characteristics - Enhancement Mode');
xlabel('Gate-Source Voltage (Vgs)');
ylabel('Drain Current (Ids)');
legend('PMOS', 'NMOS');
grid on;

% Plot Output Characteristics
subplot(2, 2, 2);
plot(Vgs_P_depletion, Ids_P_depletion, 'r', 'LineWidth', 2);
hold on;
plot(Vgs_N_depletion, Ids_N_depletion, 'b', 'LineWidth', 2);
title('Output Characteristics - Depletion Mode');
xlabel('Gate-Source Voltage (Vgs)');
ylabel('Drain Current (Ids)');
legend('PMOS', 'NMOS');
grid on;

% Plot Input Characteristics
subplot(2, 2, 3);
plot(Vgs_P_enhancement, Ids_P_enhancement, 'r', 'LineWidth', 2);
hold on;
plot(Vgs_N_enhancement, Ids_N_enhancement, 'b', 'LineWidth', 2);
title('Input Characteristics - Enhancement Mode');
xlabel('Gate-Source Voltage (Vgs)');
ylabel('Drain Current (Ids)');
legend('PMOS', 'NMOS');
grid on;

% Plot Additional Input Characteristics for Depletion Mode
subplot(2, 2, 4);
plot(Vgs_P_depletion, Ids_P_depletion, 'r', 'LineWidth', 2);
hold on;
plot(Vgs_N_depletion, Ids_N_depletion, 'b', 'LineWidth', 2);
title('Input Characteristics - Depletion Mode');
xlabel('Gate-Source Voltage (Vgs)');
ylabel('Drain Current (Ids)');
legend('PMOS', 'NMOS');
grid on;
