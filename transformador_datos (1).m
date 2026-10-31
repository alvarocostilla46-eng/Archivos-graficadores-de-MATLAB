function [x_new, y_new, dx_new, dy_new] = transformador_datos(tipo, x, y, dx, dy)

% Esta función transforma los datos y propaga errores automáticamente

switch tipo

    case 'logy'
        % y → ln(y)
        y_new = log(y);
        dy_new = dy ./ y;   % propagación: σ_ln(y) = σ_y / y

        % x no cambia
        x_new = x;
        dx_new = dx;

    case 'loglog'
        % x → ln(x), y → ln(y)
        x_new = log(x);
        y_new = log(y);

        dx_new = dx ./ x;
        dy_new = dy ./ y;

    case 'none'
        % No transformación
        x_new = x;
        y_new = y;
        dx_new = dx;
        dy_new = dy;

    otherwise
        error('Transformación no reconocida: usa "none", "logy" o "loglog"');

end

end