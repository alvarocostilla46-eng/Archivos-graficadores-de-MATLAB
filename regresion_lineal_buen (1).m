function [m,n,sm,sn,R]=regresion_lineal_buen(x,y,dy)

%% ================== VALIDACIONES ==================
if length(x)~=length(y) || length(x)~=length(dy)
    error('x, y y dy deben tener la misma longitud');
end

if any(dy==0)
    error('Los errores dy no pueden ser cero en regresión ponderada');
end

%% ================== PESOS ==================
w = 1./(dy.^2); % pesos: cuanto menor error, mayor peso

%% ================== SUMATORIOS ==================
S   = sum(w);
Sx  = sum(w.*x);
Sy  = sum(w.*y);
Sxx = sum(w.*x.^2);
Sxy = sum(w.*x.*y);

Delta = S*Sxx - Sx^2;

%% ================== PARÁMETROS ==================

% Pendiente
m = (S*Sxy - Sx*Sy)/Delta;

% Ordenada
n = (Sxx*Sy - Sx*Sxy)/Delta;

%% ================== INCERTIDUMBRES ==================

% Desviación típica de la pendiente
sm = sqrt(S/Delta);

% Desviación típica de la ordenada
sn = sqrt(Sxx/Delta);

%% ================== COEFICIENTE R² ==================

y_ajuste = m*x + n;

SS_res = sum((y - y_ajuste).^2);
SS_tot = sum((y - mean(y)).^2);

R = 1 - SS_res/SS_tot;

end