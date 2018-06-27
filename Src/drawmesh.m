function [] = drawmesh(mesh, facecolor, facealpha, edgecolor, edgealpha)
%DRAWMESH Отрисовка сетки
%   Функция выводит с помощью patch сетку.
%   mesh    - сетка
%   alpha   - прозрачность
%   color   - цвет

%   Zheltov Victor

ms = size(mesh);

if nargin < 2 
    facecolor = 0.5;
end


if nargin < 3
    facealpha = 0.5;
end

if nargin < 4
    edgecolor = 0.5;
end

if nargin < 4
    edgealpha = 0.5;
end

vertexes = zeros(ms(1) * 3, 3);
faces = zeros(ms(1), 3);
m = 0;
for j = 1 : ms(1)
    
    for k = 1 : 3
        m = m + 1;
        vertexes(m, 1:3) = mesh(j, k, :);
        faces(j, k) = m;        
    end
    
end
patch('Faces', faces, 'Vertices', vertexes, 'FaceColor', 'interp',...
        'FaceColor', facecolor, ...
        'FaceAlpha', facealpha, ...
        'EdgeColor', edgecolor, ...
        'EdgeAlpha', edgealpha);