clc; clear;

%% ================== DATOS ==================
x= [0.0025 0.01 0.02256 0.04 0.0625];

dx= [0.000001 0.000001 0.000001 0.000001 0.000001];

y = [7.2361 12.588304 20.9092804 32.2624 48.0249];

dy= [0.0108 0.0142 0.0183 0.0227 0.0277];


%% ================== TRANSFORMACIÓN ==================
% Opciones: 'none', 'logy', 'loglog'
tipo_transformador = 'none';

[x_t, y_t, dx_t, dy_t] = transformador_datos(tipo_transformador, x, y, dx, dy);

%% ================== REGRESIÓN ==================
[m,n,sm,sn,R]=regresion_lineal_buen(x_t,y_t,dy_t);

%% ================== GRÁFICA ==================
tipo='LinR';
ejeX = '(m_der-m_izq)/(m_der+m_izq)';
ejeY = 'a';
graficadorproo(x,y,dx,dy,m,n,tipo,tipo_transformador)

%% ================== RESULTADOS ==================

fprintf('================== RESULTADOS ==================\n');

% Recta
fprintf('Recta ajustada:\n');
fprintf('   y = (%.5f ± %.5f)x + (%.5f ± %.5f)\n\n',m,sm,n,sn);

% Intervalos de confianza (95%)
fprintf('Intervalos de confianza (95%%):\n');
fprintf('Pendiente: [%.5f , %.5f]\n', m-2*sm, m+2*sm);
fprintf('Ordenada:  [%.5f , %.5f]\n\n', n-2*sn, n+2*sn);

% Interpretación física rápida
fprintf('Pendiente:\n');
fprintf('   m = %.5f ± %.5f\n',m,sm);

if abs(sm/m) < 0.1
    fprintf('→ Incertidumbre relativa pequeña (ajuste fiable)\n');
else
    fprintf('→ Incertidumbre relativa grande (datos dispersos)\n');
end

fprintf('\nCoeficiente de determinación R^2 = %.5f\n',R);

fprintf('\nNúmero de datos: %d\n', length(x));

fprintf('================================================\n');
print('-dpdf', '-r300', 'figura79.pdf');
 