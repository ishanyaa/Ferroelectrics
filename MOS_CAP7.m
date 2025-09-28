%lOW AND HIGH REQUENCY P-TYPE MOS CV CHARACTERISTICS 

% Initialization and Input
format compact
close
clear


s = menu(Choose the desired plot, 'Low-f C-V', 'High-f C-V', 'Both');
NA = input('Please input the bulk doping in /cm3: NA= ');
xo = input('Please input the oxide thickness in cm:, xo= ');
xmin = input('Specify VGmin(volts), VGmin: ');
xmax = input('Specify VGmax(volts), VGmax: ');

global UF

% Constants and Parameters
e0 = 8.85e-14;
q = 1.6e-19;
k = 8.617e-5;
KS = 11.8;
KO = 3.9;
ni = 1.0e10;
T = 300;
kT = k * T;

% Compute Constants
UF = log(NA/ni);
LD = sqrt((kT * KS * e0) / (2 * q * ni));

% Gate Voltage Computation
%UF = 0.1; % Set UF to an appropriate value
US = UF - 21:0.5:UF + 21;
F = sqrt(exp(UF) * (exp(-US) + US - 1) + exp(-UF) * (exp(US) - US - 1));
VG = kT * (US + (US./abs(US)) .* (KS * xo) / (KO * LD) .* F);

% Low-frequency Capacitance Computation
DENOM = exp(UF).*(1-exp(-US))+exp(-UF).*(exp(US)-1);
WL = (US./abs(US)) .* LD .* (2 * F) ./ DENOM;
cL = 1.0 ./ (1+ (KO * WL)./(KS * xo));

% High-frequency Capacitance Computation
if s ~= 1
    jj = length(US);
    nn = 0;
    for ii = 1:jj,
        if US(ii) < 3
             elseif nn == 0,
                 INTG = QUAD('CVintgrd', 3, US(ii), 0.001);
                 nn = 1;
                 else
                 INTG = INTG + QUAD('CVintgrd', US(ii - 1), US(ii), 0.001);
                 end
        if US(ii) < 3,
            cH(ii) = cL(ii);
            else
            d = (exp(US(ii)) -US(ii) - 1) ./ (F(ii) * exp(UF) .* INTG);
            DONOMH = exp(UF) .* (1+ exp(-US(ii)))+exp(-UF).*((exp(US(ii))-1)./(1+d));
            WH = LD .* (2 * F(ii))./DONOMH;
            cH(ii) = 1.0 ./ (1 + (KO * WH) ./ (KS * xo));
            end
        end
else
end



       
            

% Plotting the Result 
if s ==1,
plot (VG,cL);
elseif s== 2,
plot(VG, cH);
else
plot(VG,cL, '--', VG, cH);
text(0.8*xmin,.17,'---Low-f', 'color', [1,1,0]);
text(0.8*xmin,.12,'__High-f', 'color', [1,0,1]);
end
axis([xmin, xmax, 0, 1]);
text(0.8*xmin,.27, ['NA =', num2str(NA),'/cm3']);
text(0.8*xmin,.22,['xo=',num2str(xo), 'cm']);
xlabel('Gate Voltage (V)');
ylabel('C/CO');
grid on;

CVintgrd
function [y]=cvintergrand(U)
globalUF
F=sqrt(exp(UF).*(exp(-U)+U-1)+exp(-UF).*(exp(U)-U-1));
y=(1-exp(-U)).*(exp(U)-U-1)./(2*F.^3);


%figure;
%plot(US, VG, 'LineWidth', 2);
%hold on;
%plot(US, cL, 'LineWidth', 2); % Placeholder for low-frequency capacitance
%plot(US, cH, 'LineWidth', 2); % Placeholder for high-frequency capacitance
%title('MOS-C C-V Characteristics');
%xlabel('Gate Voltage (V)');
%ylabel('Capacitance (F)');
%legend('Gate Voltage', 'Low-frequency', 'High-frequency');
%grid on;
