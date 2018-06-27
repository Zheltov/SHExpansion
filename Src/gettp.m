function [ theta, phi ] = gettp( ntheta, nphi )
% GETTP Получение углов тета и фи по заданному их количеству
%   Функция возвращает вектора с углами тета и фи для расчетов по СГ
%   ntheta  - количество углов тета
%   nphi    - количество углов фи
%   theta   - углы тета
%   phi     - углы фи

%   Zheltov Victor


theta = 0 : ( pi / (ntheta - 1) ) : pi;
phi = 0 : ( 2*pi / (nphi - 1) ) : 2*pi;