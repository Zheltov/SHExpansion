function [ ] = drawaf( r, theta, phi, center, facecolor, facealpha, edgecolor, edgealpha )
% DRAWAF вывод с помощью patch угловой функции
%   r       - угловая функция заданная по углам theta, phi
%   theta   - углы по тета
%   phi     - углы по фи
%   center  - центр
%   color   - цвет
%   alpha   - прозрачность

if ( nargin < 4 )
    center = [0 0 0];
end

if ( nargin < 5 )
    facecolor = [.5 .5 .5];
end

if ( nargin < 6 )
    facealpha = .5;
end

if ( nargin < 7 )
    edgecolor = [.5 .5 .5];
end

if ( nargin < 8 )
    edgealpha = .5;
end

nt = length(theta);
np = length(phi);

[x, y, z] = sph2cart(repmat(phi, nt, 1), pi/2 - repmat(theta', 1, np), r);

[f, v] = surf2patch(x + center(1), y + center(2), z + center(3));

patch('Faces', f, 'Vertices', v,...
    'FaceColor', facecolor,...
    'FaceAlpha', facealpha, ...    
    'EdgeColor', edgecolor, ...
    'EdgeAlpha', edgealpha);