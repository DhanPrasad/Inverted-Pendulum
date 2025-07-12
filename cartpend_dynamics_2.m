function dx = cartpend_dynamics_2(x, m, M, L, g, u)
    % Linearized inverted pendulum dynamics (around upright position)
    % x = [position; velocity; angle; angular velocity]
    % x(2) = v, x(4) = angular velocity
    dx = zeros(4,1);
    pos = x(1);
    vel = x(2);
    theta = x(3);
    theta_d = x(4);

    ct = cos(theta);
    st = sin(theta);
    denom_theta = 1/(L*(M+m*(1-ct*ct)));
    denom_pos = 1/(M+m*(1-ct*ct));
    
    dx(1) = vel;  % x_dot
    dx(2) = (1/M) * (m * g * theta + u);  % x_ddot
    %dx(2) = denom_pos*(u - m*L*theta_d*theta_d*st + m*g*ct*st); %for non-linear dynamics uncomment this
    dx(3) = theta_d;  % theta_dot
    dx(4) = (1/(M * L)) * ((M + m) * g * theta + u);  % theta_ddot
    %dx(4) = denom_theta *(u*ct - m*L*theta_d*theta_d*ct*st +m*g*ct*ct*st); %for non-linear dynamics uncomment this
end
