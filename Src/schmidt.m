function [ Qkm ]= schmidt( mu, N )
%SHMIDT Расчёт полиномов Шмидта
%   Расчёт полиномов Qkm (Schmidt), Rkm, Tkm - действительных - для
%   поляризационных расчетов
%   mu	- массив зенитного косинусов угла
%   N	- порядок приближения (как есть в теории - т.е. считая с 0)
%   если mu - вектор, то 
%   Qkm(Nmu, N + 1, N + 1)
%   если mu - скаляр, то
%   Qkm(N + 1, N + 1)

% Budak P. Vladimir, исправление Qkm на квадратную Zheltov Victor

if ( length(mu) == 1 )
% Integer constants
    N1 = N + 1;
% Real constants
    mu2 = mu ^ 2;
    smu = sqrt(1 - mu2);
% Output arrays for all the polynomials Q, R, T for all degrees l, azimuth m and angles
    Qkm = zeros(N1, N1);
% Azimuthal loop
    Qkm(1, 1) = 1;
    for m = 0: N
        m1 = m + 1;
        m2 = m^2;
%               Renormolized Legendre polynomial
        if m > 0
%                                       Compute Qmm
            somx2 = smu ^ m;
            d = 2: 2: 2*m;
            Qkm(m1,m1) = sqrt(prod(1 - 1 ./ d)) * somx2;
        end
%                                       Compute Qmm+1
        if ( m1 < N )
            Qkm(m1+1,m1) = sqrt(2*m + 1) * mu * Qkm(m1,m1);
        end
%                                       Compute Qml, l > m + 1
        for k = (m + 2): N
            Qkm(k+1,m1) = ((2*k-1)*mu' * Qkm(k,m1) - sqrt((k-1)^2-m2)*Qkm(k-1,m1)) / sqrt(k^2-m2);
        end
    end
else
% Integer constants
    Nmu = length(mu);
    N1 = N + 1;
% Real constants
    mu2 = mu .^ 2;
    smu = sqrt(1 - mu2);
% Output arrays for all the polynomials Q, R, T for all degrees l, azimuth m and angles
    Qkm = zeros(Nmu, N1, N1);
% Azimuthal loop
    Qkm(:, 1, 1) = ones(1, Nmu);
    for m = 0: N
        m1 = m + 1;
        m2 = m^2;
%               Renormolized Legendre polynomial
        if m > 0
%                                       Compute Qmm
            somx2 = smu .^ m;
            d = 2: 2: 2*m;
            Qkm(:,m1,m1) = sqrt(prod(1 - 1 ./ d)) * somx2;
        end
%                                       Compute Qmm+1
        if ( m1 < N )
            Qkm(:,m1+1,m1) = sqrt(2*m + 1) * mu' .* Qkm(:,m1,m1);
        end
%                                       Compute Qml, l > m + 1
        for k = (m + 2): N
            Qkm(:,k+1,m1) = ((2*k-1)*mu'.*Qkm(:,k,m1) - sqrt((k-1)^2-m2)*Qkm(:,k-1,m1)) / sqrt(k^2-m2);
        end
    end
end