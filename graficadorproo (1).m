function graficadorproo (x,y,dx,dy,m,n,tipo,tipo_transformacion)
%% ================== VALIDACIONES ==================
if length(x)~=length(y) || length(x)~=length(dx) || length(x)~=length(dy)
    error('Todos los vectores (x, y, dx, dy) deben tener la misma longitud');
end
if any(isnan(x)) || any(isnan(y)) || any(isnan(dx)) || any(isnan(dy))
    error('Hay valores NaN en los datos');
end
if any(isinf(x)) || any(isinf(y)) || any(isinf(dx)) || any(isinf(dy))
    error('Hay valores Inf en los datos');
end
if any(dx < 0) || any(dy < 0)
    error('Los errores deben ser positivos');
end
%% ================== ORDENAR ==================
[x_sorted, idx] = sort(x);
y_sorted = y(idx);
dx_sorted = dx(idx);
dy_sorted = dy(idx);
%% ================== ETIQUETAS AUTOMÁTICAS ==================
switch tipo_transformacion
    case 'none'
        xlabel_txt = "d^2 m^2";
        ylabel_txt = "T^2 s^2";
        titulo_txt = '';
    case 'logy'
        xlabel_txt = "a(m/s^2)";
        ylabel_txt = "F(N)";
        titulo_txt = '';
    case 'loglog'
        xlabel_txt = "a(m/s^2)";
        ylabel_txt = "F(N)";
        titulo_txt = '';
    otherwise
        xlabel_txt = "a(m/s^2)";
        ylabel_txt = "F(N)";
        titulo_txt = '';
end
%% ================== RANGO PARA LA RECTA ==================
xmin = min(x_sorted);
xmax = max(x_sorted);
margen = 0.1*(xmax - xmin);
x_fit = linspace(xmin - margen, xmax + margen, 1000);
y_fit = m*x_fit + n;
%% ================== GRAFICADO ==================
switch tipo
    case 'scatter'
        figure ('Color', 'w', 'Units', 'normalized', 'Position', [0.1, 0.1, 0.7, 0.8]);
        figure;
        errorbar(x_sorted, y_sorted, dy_sorted, dy_sorted, dx_sorted, dx_sorted, ...
            'o', 'MarkerFaceColor','b');
        title(titulo_txt); 
        xlabel(xlabel_txt, "FontSize", 20); 
        ylabel(ylabel_txt, "FontSize",20); 
        axis square;
        legend off;
        grid off;
        legend off;
    case 'LinR'
        figure;
        figure ('Color', 'w', 'Units', 'normalized', 'Position', [0.1, 0.1, 0.7, 0.8]);
        errorbar(x_sorted, y_sorted, dy_sorted, dy_sorted, dx_sorted, dx_sorted, ...
            'o', 'MarkerFaceColor','b');
        hold on;
        plot(x_fit, y_fit, 'r', 'LineWidth', 1.5);
        xlim([min(x_fit), max(x_fit)])
        title([titulo_txt ' ']); 
        xlabel(xlabel_txt, "FontSize",20); 
        ylabel(ylabel_txt,  "FontSize",20); 
        axis square;
        legend off;
        grid off;
        legend off;
    case 'both'
        figure;
        figure ('Color', 'w', 'Units', 'normalized', 'Position', [0.1, 0.1, 0.7, 0.8]);
        errorbar(x_sorted, y_sorted, dy_sorted, dy_sorted, dx_sorted, dx_sorted, ...
            'o', 'MarkerFaceColor','b');
        hold on;
        plot(x_fit, y_fit, 'r', 'LineWidth', 1.5);
        title([titulo_txt ' ']); 
        xlabel(xlabel_txt, "FontSize",20); 
        ylabel(ylabel_txt, "FontSize",20); 
        axis square;
        legend off;
        grid off;
        legend off;
    otherwise
        error('Tipo no reconocido');
end
%% ================== ESTÉTICA ==================
set(gca,'FontSize',20)
end