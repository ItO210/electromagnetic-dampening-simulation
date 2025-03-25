clear, clc

m = input('Enter the mass (kg): ');
z0 = input('Enter the initial height (m): ');
Fh = input('Enter the height (m): ');

g = 9.81;
Mu = 4*pi*(10^-7);
area = 0.5;
R = 0.000009;
U = 100000000000;
v0 = 0;
s = 0.01;
t = 0; % tiempo
h = z0; % altura
v = v0; % velocidad

% Grafica
figure(1);
xlabel('x (m)');
ylabel('Altura (m)');
title('Animación de caída libre');
hold on;

xlim([-1 1]);
ylim([0 z0+(z0/10)]);

rectangle('Position', [-.2  0 .4 z0], 'FaceColor', 'blue');
p = patch([-0.5 -0.5 0.5 0.5], [z0 z0+1 z0+1 z0],'cyan');
v_text = text(-0.8, z0-1, sprintf('Velocity: %.2f m/s', v));

h_values = [];
v_values = [];
a_values = [];
t_values = [];

while h > Fh
    set(v_text, 'String', sprintf('Velocity: %.2f m/s', v));
    set(p, 'YData', [h h+1 h+1 h]);

    a = (m * g - 0) / m;
    v = a * t;
    h = z0 - (v * t);
    pause(.01);

    h_values = [h_values, h];
    v_values = [v_values, v];
    a_values = [a_values, a];
    t_values = [t_values, t];

    t = t + s;
end

f_func = @(v) v;
g_func = @(x,z,v) -(((9*((Mu*U*(area^2))^2))/(4*R) * (z^2)/(((area^2)+(z^2))^5))/m)*v - g;

[x1,z1,v1] = RK4(f_func, g_func, t, t+4, s, h, -v);

jerk_exceeded = false;

for i = 1:length(x1)
    if z1(i) > 0
        set(v_text, 'String', sprintf('Velocity: %.2f m/s', -v1(i)));
        set(p, 'YData', [z1(i) z1(i)+1 z1(i)+1 z1(i)]);
    
        pause(0.01);
        
        if i > 2
            acceleration = (v1(i) - v1(i-1)) / s;
            jerk = (acceleration - (v1(i-1) - v1(i-2)) / s) / s;
            
            if jerk > 100
                jerk_exceeded = true;
            end
    
        end
    end
end

figure;
subplot(1,3,1);
plot(x1,z1)
hold on;
plot(t_values,h_values)
xlabel("Tiempo")
ylabel("Altura")
title('Altura-tiempo')

subplot(1,3,2);
plot(x1,-v1)
hold on;
plot(t_values,v_values)
xlabel("Tiempo")
ylabel("Velocidad")
title('Velocidad-tiempo')

subplot(1,3,3);
t = t:s:t+4;
ac = diff(v1) ./diff(t);
x1 = x1(1:end-1);
plot(x1,ac)
hold on;
plot(t_values,a_values)
xlabel("Tiempo")
ylabel("Aceleracion")
title('Aceleracion-tiempo')

if jerk_exceeded
    disp('El limite jerk de 100 m/s³ ha sido exedido.')
else
    disp('El limite jerk de 100 m/s³ no ha sido exedido.')
end


%%
function[x,y,z] = RK4(f,g,ti,tf,s,y0,z0)
    x = ti:s:tf;
    n = length(x);
    y = zeros(1,n);
    z = zeros(1,n);
    y(1) = y0;
    z(1) = z0;
    
    for i = 1:n-1
            k1 = s*f(z(i));
            il = s*g(x(i),y(i),z(i));
    
            k2 = s*f(z(i)+ 0.5*il);
            i2 = s*g(x(i)+0.5*s, y(i)+ 0.5 *k1, z(i)+0.5*il);
    
            k3 = s*f(z(i) + 0.5*i2);
            i3 = s*g(x(i) + 0.5*s, y(i) + 0.5 * k2, z(i) +0.5*i2);
    
            k4 = s*f(z(i) + i3);
            i4 = s*g(x(i) + s,y(i) + k3*s, z(i) + i3);
    
            y(i+1) = y(i) + (k1 + 2*k2 + 2*k3 +k4) *(1/6);
            z(i+1) = z(i) + (il +2*i2 + 2* i3 + i4)*(1/6);
    end
end