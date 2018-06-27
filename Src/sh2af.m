function [r] = sh2af(A, B, N, theta, phi)
%SH2AF Преобразование спектра в угловую функцию
%   Функция вычисляет угловую функцию по заданному спектру до N-й
%   гармоники.
%   A       - косинусные коэффициенты
%   B       - синусные коэффициенты
%   N       - количество коэффициентов разложения
%   theta   - набор углов тета
%   phi     - набор углов фи
%   r       - радиус вектора заданные по углам тета, фи

%   Zheltov Victor

Qkm = schmidt(cos(theta), N - 1);

if ( length(theta) == 1 && length(phi) == 1 )
    
    r = 0;
    for m = 0 : N - 1
        m1 = m + 1;
        r = r + sum(Qkm(:, m1) .* (A(:, m1)*cos(m*phi) + B(:, m1)*sin(m*phi)));
    end
    
else
    r = zeros(length(theta), length(phi));

    for m = 0 : N - 1
        m1 = m + 1;
        r = r + Qkm(:, :, m1) * (A(:, m1)*cos(m*phi) + B(:, m1)*sin(m*phi));
    end
    
end