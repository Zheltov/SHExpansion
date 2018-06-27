function [ theta, phi ] = gettp( ntheta, nphi )
% GETTP ��������� ����� ���� � �� �� ��������� �� ����������
%   ������� ���������� ������� � ������ ���� � �� ��� �������� �� ��
%   ntheta  - ���������� ����� ����
%   nphi    - ���������� ����� ��
%   theta   - ���� ����
%   phi     - ���� ��

%   Zheltov Victor


theta = 0 : ( pi / (ntheta - 1) ) : pi;
phi = 0 : ( 2*pi / (nphi - 1) ) : 2*pi;