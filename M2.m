% Surface potential vs. Gate voltage for MOS Capacitor  

%Initialize the range of the surface potential 
psi = -0.2:0.01:1.2; %[V] 

%Specify the physical constants  
epsilon_siO2 = 4*8.854*1e-14; %Permittivity of SiO2 [F/cm] 

epsilon_si = 11.68*8.854*1e-14; %Permittivity of Si [F/cm] 
k_b = 1.380e-23; %Boltzmann constant [J/K] 
q = 1.6e-19; %Elementary charge [C]  


%Specify the environmental parameters 
TL = 300; %Room temperature[Kelvin] 
ni = 1e10; %Intrinsic semiconductor carrier density  for silicon[cm-3] 
N_A = 5e17; %Acceptor concentration [cm-3] 
tox = 2e-7; %The thickness of SiO2 in capacitor[cm] 
V_FB = 0; %The flat-band voltage [V]  

%Calculate the capacitance per unit area 
cox = epsilon_siO2/tox; %[F/cm2]  


%Calculate the F function (to calculate the total charge) with respect to different surface potentials.  See: eqn. (10) in [1]  
F_psi1 = exp(-psi*q/k_b/TL) + psi*q/k_b/TL -1; %using the equations separtely as F_psi1 and F_psi2
F_psi2 = ni^2/N_A^2*(exp(psi*q/k_b/TL) - psi*q/k_b/TL -1); 
F_psi = sqrt(F_psi1 + F_psi2);  


%Initialize the vectors 
psi_length = length(psi); 
Qs = zeros(psi_length,1);  
V_G = zeros(psi_length,1); 
psi_B = zeros(psi_length,1); 

%Calculate the total charges and the corresponding gate voltages. See eqn. (12) in [1]   Total charge in semiconductor as a function of surface potential  as   

for i = 1:psi_length   
    if psi(i) <= 0             
        Qs(i) = sqrt(2*epsilon_si*k_b*TL*N_A)*F_psi(i);  %Calculate charge when the surface potential is negative 
         
    else         
        Qs(i) = -sqrt(2*epsilon_si*k_b*TL*N_A)*F_psi(i);  %Calculate charge when the surface potential is positive
    end        
    
    psi_B(i) = k_b*TL/q*log(N_A/ni); %Get the bulk potential as a reference and it is a constant with respect to VG     
    
    V_G(i) = V_FB+psi(i)-Qs(i)/cox; %Calculate the gate voltage 
end

%Plot total charge vs. surface potential (psi_S) 
figure(1) 
semilogy(psi,abs(Qs)/q,'r','linewidth',3); 
hold on 
set(gca, 'xlim', [-0.4 1.4], 'ylim', [1e11 1e14]); 
set(gca,'fontsize',13); 
xlabel('\psi_S (V)'); 
ylabel('|Qs|/q (cm^-2)'); 

%Plot x=0 
plot(zeros(1,21),logspace(10,16,21),'k--') 

%Plot surface potential (psi_S) vs. gate voltage with reference 
potential = 2*psi_B
figure(2) 
h1=plot(V_G,psi,'r','linewidth',3); 
xlabel('V_G (V)'); 
ylabel('\psi_S (V)'); 
hold on h2=plot(V_G,2*psi_B,'--b','linewidth',3); 
set(gca, 'xlim', [-3 10], 'ylim', [-0.4 1.4]); 
set(gca,'fontsize',13); 
legend('\psi_S','2*\psi_B','Location','SouthEast') 
 

%Plot x=0 and y=0 
plot(-10:10, zeros(1,21), 'k--') 
plot(zeros(1,21),-10:10, 'k--') 


% Initialize arrays for charge density and electric field
chargeDensity = zeros(size(VG));
electricField = zeros(size(VG));

% Calculate charge density and electric field
for i = 1:length(VG)
    % Solve Poisson-Boltzmann equation numerically
    psi = ode45(@(x, psi) F(psi, interp1(VG, VG, x)), [0 L], 0);
    
    % Calculate charge density (assuming it's dominated by electrons in this example)
    n = ni * exp(q * psi.y / (kB * T));
    chargeDensity(i) = trapz(psi.x, q * n);
    
    % Calculate electric field
    E = -gradient(psi.y, psi.x);
    electricField(i) = E(end);
end

% Plot charge density vs. gate voltage
figure;
plot(VG, chargeDensity);
xlabel('Gate Voltage (V)');
ylabel('Charge Density (C/m^2)');
title('Charge Density vs. Gate Voltage');

% Plot electric field vs. gate voltage
figure;
plot(VG, electricField);
xlabel('Gate Voltage (V)');
ylabel('Electric Field (V/m)');
title('Electric Field vs. Gate Voltage');