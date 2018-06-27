function [hfig] = createform()
%CREATEFORM создание формы
%   hfig - дескриптор формы

%   Zheltov Victor

scrsz = get(0, 'screensize');
w = 960;
h = 550;
hfig = figure('position', [(scrsz(3) - w) / 2, (scrsz(4) - h) / 2, ...
    w, h], 'units', 'pixels', 'renderer', 'opengl', ...
    'name', 'shexpansion', 'numbertitle', 'off', ...
    'dockcontrols', 'off', 'doublebuffer', 'on', 'color', [0.5 0.5 0.75]);
cameratoolbar(hfig);

set(gca, 'dataaspectratiomode', 'manual');
set(gca, 'color', [0.5 0.5 0.75]);
xlabel(gca, 'x');
ylabel(gca, 'y');
zlabel(gca, 'z');