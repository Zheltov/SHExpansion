% Преобразование угловой функции в сетки
% Вход:
%   r           - радиус вектор по углам
%   theta       - углы по тета
%   phi         - углы по фи
%   center      - центр объекта
% Выход:
%   Faces       - грани
%   Vertexes    - вершины
function [Faces, Vertexes] = af2mesh(r, theta, phi, center)

ntheta = length(theta);
nphi = length(phi);
nphi1 = nphi - 0;

Vertexes(1 : ntheta * nphi, 1:3) = 0;

iVertex = 1;
for i = 1 : ntheta
    for j = 1 : nphi
        % добавляем вершины
        [x, y, z] = sph2cart(phi(j), theta(i) - pi/2, r(i, j));
        Vertexes(iVertex, 1:3) = [x + center(1) y + center(2) z + center(3)];
        iVertex = iVertex + 1;
    end
end

iFace = 1;
for i = 1 : ntheta - 1
    for j = 1 : nphi - 1

        % формируем грани, расчитывая индексы смещения вершин в Vertexes
        % формируем треугольные грани, поэтому на каждом шаге формируется
        % две грани для сектора сферы заданного 4 углами: [(i, j) (i+1, j)
        % (i+1, j+1) (i, j+1)]
        % можно это выполнить и в предыдущем цикле, но так более наглядно
        
        index1 = ((i - 1) * nphi1) + (j + 0);
        index2 = ((i - 1) * nphi1) + (j + 1);
        index3 = ((i + 0) * nphi1) + (j + 1);
        index4 = ((i + 0) * nphi1) + (j + 0);

        Faces(iFace, 1:3) = [index1 index2 index3];
        Faces(iFace + 1, 1:3) = [index1 index3 index4];
                
        iFace = iFace + 2;
    end
end