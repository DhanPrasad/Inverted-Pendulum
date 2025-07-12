clear all; close all; clc  

% Parameters
m = 0.1;     % Pendulum mass
M = 1.0;     % Cart mass
L = 3;       % Pendulum length (to COM)
g = 9.8;     % Positive gravity (upright case)

init_disturbance = 1;  % Small angle offset from vertical (which is 0). 

%% Linearized dynamics about upright (theta ≈ 0)
A = [0 1 0 0;
     0 0 (m*g)/M 0;
     0 0 0 1;
     0 0 (M + m)*g/(M*L) 0];

B = [0;
     1/M;
     0;
     1/(M*L)];
Q = [100 0 0 0;
    0 10 0 0;
    0 0 10 0;
     0 0 0 10];
R = 0.01;

%% Pole Placement
p = [-1, -1.2, -1.3, -1.4];
%K = place(A, B, p); % POle placement for calculating K 
K = lqr(A, B, Q, R); % LQR method for determining control gain matrix

%% Control Law
ref_state = [0; 0; 0; 0]; % stable position, velocity, angular position, and angular velocity respectively that we want our pendulum
control_law = @(x) -K * (x - ref_state);

%% Simulation
t_sim = 0:0.01:15;
x0 = [0; 0; init_disturbance; 0]; % where we want out pendulum start from

[t, y] = ode45(@(t, x) cartpend_dynamics_2(x, m, M, L, g, control_law(x)), t_sim, x0);

%% Plot Results
figure;
subplot(2,2,1);
plot(t, y(:,1), 'LineWidth', 1.5);
ylabel('Cart Position (x) [m]');
grid on;

subplot(2,2,3);
plot(t, y(:,2), 'LineWidth', 1.5);
ylabel('Cart Velocity (x^.) [m/s]');
grid on;

subplot(2,2,2);
plot(t, y(:,3), 'LineWidth', 1.5);
ylabel('Pendulum Angle (θ) [rad]');
grid on;

subplot(2,2,4);
plot(t, y(:,4), 'LineWidth', 1.5);
ylabel('Pendulum Angular Velocity (θ̇) [rad/s]');
xlabel('Time [s]');
grid on;

%% Animation 
% Extract simulation data
x_cart = y(:,1);
theta  = y(:,3);

% Animation Setup
% Pendulum positions
x_pend = x_cart + L * sin(theta);
y_pend = L * cos(theta);

cart_w = 0.8;
cart_h = 0.4;

% Prepare figure
fig = figure('Color', 'w');
set(fig, 'Units', 'normalized', 'OuterPosition', [0 0 1 1]);  % Fullscreen

ax = axes('Parent', fig);
axis(ax, 'equal');
axis(ax, [-15 5 -L L+4]);
grid(ax, 'on');

% Major grid customization
ax.GridLineStyle = '-';         % solid line
ax.GridColor = [0 0 0];         % black
ax.GridAlpha = 0.1;             % fully opaque

% Minor grid customization
ax.XMinorTick = 'on';
ax.XMinorGrid = 'on';
ax.MinorGridLineStyle = '-';    % solid line
ax.MinorGridColor = [0 0 0];    % black
ax.MinorGridAlpha = 0.1;        % fully opaque

xlabel(ax, 'X Position [m]');
ylabel(ax, 'Y Position [m]');
hold(ax, 'on');

% File to save
filename = 'IPS_Pole_Placement3.gif';
xtrace = [];
ytrace = [];

for k = 1:20:length(t)
    cla(ax);  % Clear axes only

    % Update trace
    xtrace(end + 1) = x_pend(k);
    ytrace(end + 1) = y_pend(k);

    % Draw cart
    cart_x = x_cart(k) - cart_w/2;
    cart_y = -cart_h/2;
    rectangle(ax, 'Position', [cart_x, cart_y, cart_w, cart_h],'FaceColor', [0 0.4 0.8], 'EdgeColor', 'k');

    % Draw pendulum rod
    line(ax, [x_cart(k), x_pend(k)], [0, y_pend(k)],'Color', 'k', 'LineWidth', 2);

    % Draw pendulum bob
    plot(ax, x_pend(k), y_pend(k), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

    % Trace path
    plot(ax, xtrace, ytrace, '.', 'Color', 'r');

    title(ax, sprintf('Time = %.2f s', t(k)));

    drawnow;

    % Capture and save to GIF
    frame = getframe(fig);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);

    if k == 1
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.03);
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.03);
    end
end
