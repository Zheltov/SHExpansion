function [objects]  =  read3ds(filename, scale)
% READ3DS ������ 3ds �����
% ������ �������� ����� ������� 3ds � ��������� objects
%   fileName    - ��� �����
%   scale       - ���������� �����������
%   objects     - ��������� ����������� ����� � ������:
%           mesh    - �����
%           name    - ��� �������
%           center  - ����������� ����� �������

% ��������� ����
fid = fopen(filename);

% ��������� �������� � �����
fseek(fid, 22, 'bof');

iobject = 0;
objects = struct('mesh', [], 'name', [], 'center', [], 'rmax', [], 'rmin', []);

% ���� �� �������
chunk_id = fread(fid, 1, 'int16');
chunk_len = fread(fid, 1, 'int32');
fposNextObject = ftell(fid) + chunk_len - 6;
while ~feof(fid) 

    % ������ ������ ��������
    if chunk_id == 16384

        % ��� ������� �� ����������, �� ������ ������� �� ������� � ����� 0
        ch = 10;
        name = '';
        while ch ~= 0
            ch = fread(fid, 1, 'int8');
            name = strcat(name, char(ch));
        end
        chunk_id = fread(fid, 1, 'int16');
        fread(fid, 1, 'int32');
        
        
        % �������� ������
        if chunk_id == 16640
            
            iobject = iobject + 1;
            
            objects(iobject).name = name;
            
            %������ ������
            chunk_id = fread(fid, 1, 'int16');
            chunk_len = fread(fid, 1, 'int32');
            FF = ftell(fid) + chunk_len - 6;

            if chunk_id == 16656
                % ������ ������
                N = fread(fid, 1, 'int16');
                
                Vertexes = zeros(N, 3);
                for i = 1 : N
                  Vertexes(i, 1) = scale * fread(fid, 1, 'float32');
                  Vertexes(i, 2) = scale * fread(fid, 1, 'float32');
                  Vertexes(i, 3) = scale * fread(fid, 1, 'float32');
                end
                
            end
            
            %���������� � ������
            fseek(fid, FF, 'bof');   
            chunk_id = fread(fid, 1, 'int16');
            chunk_len = fread(fid, 1, 'int32');
            while chunk_id ~= 16672
                fseek(fid, chunk_len - 6, 0);
                chunk_id = fread(fid, 1, 'int16');
                chunk_len = fread(fid, 1, 'int32');        
            end 

            N = fread(fid, 1, 'int16');
            objects(iobject).mesh = zeros(N, 3, 3);
            for i = 1 : N
                p = fread(fid, 4, 'int16');
                objects(iobject).mesh(i, :, :) = Vertexes(p(1:3) + 1, :);
            end
            
            objects(iobject).center = squeeze( sum(sum(objects(iobject).mesh)) / (3*size(objects(iobject).mesh, 1)) )';

        end
    end
    
    
    % ��������� � ���������� ������� � �����
    fseek(fid, fposNextObject, 'bof');
    chunk_id = fread(fid, 1, 'int16');
    chunk_len = fread(fid, 1, 'int32');
    fposNextObject = ftell(fid) + chunk_len - 6;
end

% ��������� ����
fclose(fid);