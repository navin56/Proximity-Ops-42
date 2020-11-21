%% Plot Utils for 42

% Of course No Matlab script starts without this.
clc;
close all;

% It would be stupid to reload this over and over.
clearvars -except SC0_Pos_ECI SC0_Vel_ECI SC1_Pos_ECI SC1_Vel_ECI;

%% Init
% FSW Delta-t
delta_t = 0.2;
% 30000 Seconds.
sim_end_t = 120000;
t = 0:sim_end_t;

%% Load the Position and Velocity Vectors for both Spacecrafts.
% Assumes files are present in same directory as the Script.
if (exist('SC0_Pos_ECI','var') && exist('SC0_Vel_ECI','var') && exist('SC1_Pos_ECI','var') && exist('SC1_Vel_ECI','var')) == 0
    SC0_Pos_ECI = importdata('PosN.42');
    SC0_Vel_ECI = importdata('VelN.42');

    SC1_Pos_ECI = importdata('PosN1.42');
    SC1_Vel_ECI = importdata('VelN1.42');
end

%% Hmm, Plot Orbits.
figure('Name', 'Orbit Plots - XY');
plot(SC0_Pos_ECI(:,1), SC0_Pos_ECI(:,2), 'b');
title('Target Oribt');
hold on;
plot(SC1_Pos_ECI(:,1), SC1_Pos_ECI(:,2), 'r');
hold off;
xlabel('Position X - km');
ylabel('Position Y - km');
legend('Target Position', 'Chaser Position');

%% Plot Difference in Positions.
Diff_Pos_ECI = SC0_Pos_ECI - SC1_Pos_ECI;
figure('Name', 'Position Difference in ECI Frame');
plot(Diff_Pos_ECI(:,1), Diff_Pos_ECI(:,2));
xlabel('Position X - km');
ylabel('Position Y - km');

%% Plot Velocities
figure('Name', 'Orbital Velocity Plots - XY');
plot(SC0_Vel_ECI(:,1), SC0_Vel_ECI(:,2), 'b');
title('Target Oribt');
hold on;
plot(SC1_Vel_ECI(:,1), SC1_Vel_ECI(:,2), 'r');
hold off;
xlabel('Velocity VX - km/s');
ylabel('Position VY - km/s');
legend('Target Position', 'Chaser Position');

%% Plot Difference in Velocities.
Diff_Vel_ECI = SC0_Vel_ECI - SC1_Vel_ECI;
figure('Name', 'Velocity Difference in ECI Frame');
plot(Diff_Pos_ECI(:,1), Diff_Pos_ECI(:,2));
xlabel('Position VX - km/s');
ylabel('Position VY - km/s');

%% Time vs Rmag, Vmag ()
SC0_Rmag = sqrt(SC0_Pos_ECI(:,1).^ 2 + SC0_Pos_ECI(:,2).^ 2 + SC0_Pos_ECI(:,3).^ 2);
SC1_Rmag = sqrt(SC1_Pos_ECI(:,1).^ 2 + SC1_Pos_ECI(:,2).^ 2 + SC1_Pos_ECI(:,3).^ 2);

figure('Name', 'Time vs Rmag');
plot(t, SC0_Rmag);
hold on;
plot(t, SC1_Rmag);
hold off;
xlabel('Time - (sec)');
ylabel('Mag Position');
legend('Target Rmag', 'Chaser Rmag');

%% Time vs Vmag
SC0_Vmag = sqrt(SC0_Vel_ECI(:,1).^ 2 + SC0_Vel_ECI(:,2).^ 2 + SC0_Vel_ECI(:,3).^ 2);
SC1_Vmag = sqrt(SC1_Vel_ECI(:,1).^ 2 + SC1_Vel_ECI(:,2).^ 2 + SC1_Vel_ECI(:,3).^ 2);

figure('Name', 'Time vs Vmag');
plot(t, SC0_Vmag, 'b');
hold on;
plot(t, SC1_Vmag, 'r');
hold off;
xlabel('Time - (sec)');
ylabel('Mag Velocity');
legend('Target Vmag', 'Chaser Vmag');
