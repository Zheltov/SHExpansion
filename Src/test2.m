% ������� �����
createform();

%% ��������� ���������
N = 32;                 % ����� ��������
ntheta = 64;            % ��������� �� ���� ����
nphi = 64;              % ��������� �� ���� ��

%% �������

% ������ 3ds ����� � ��������� objects
[status, currdir] = system('cd');
[objects] = read3ds(strcat(currdir,'\3ds\head.3ds'), 1);

% �������� ������� ����� �� ������� ����� ��������� ����������
[theta, phi] = gettp(ntheta, nphi);
% ������������ ����� ������� ������� � ������� ������� ������������ ������
% ���� �������
[r] = mesh2af(objects(1).mesh, objects(1).center, theta, phi, 'full');

% ����������� ������� ������� �� ��
[A, B] = af2sh(r, theta, phi, N);

% �������� ����� ������ ������� ������� ������������ �� �������
r = sh2af(A, B, N, theta, phi);

%% ���������� ��������
% ������ ����������
drawaf(r, theta, phi, [0 -25 0], [.0 .8 .0], .5, [0 0 0], .5 );

% ������ ������� �������
% drawmesh(objects(1).mesh, [.5 .5 .5], .5, [0 0 0], .5);