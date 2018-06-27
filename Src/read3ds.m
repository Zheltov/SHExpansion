function [objects]  =  read3ds(filename, scale)
% READ3DS чтение 3ds файла
% Чтение объектов файла формата 3ds в структуру objects
%   fileName    - имя файла
%   scale       - масштабный коэффициент
%   objects     - структура описывающая сетку с полями:
%           mesh    - сетка
%           name    - имя объекта
%           center  - центральная точка объекта

% открываем файл
fid = fopen(filename);

% начальное смещение в файле
fseek(fid, 22, 'bof');

iobject = 0;
objects = struct('mesh', [], 'name', [], 'center', [], 'rmax', [], 'rmin', []);

% идем по порциям
chunk_id = fread(fid, 1, 'int16');
chunk_len = fread(fid, 1, 'int32');
fposNextObject = ftell(fid) + chunk_len - 6;
while ~feof(fid) 

    % порция данных объектов
    if chunk_id == 16384

        % имя объекта не используем, но делаем пропуск до символа с кодом 0
        ch = 10;
        name = '';
        while ch ~= 0
            ch = fread(fid, 1, 'int8');
            name = strcat(name, char(ch));
        end
        chunk_id = fread(fid, 1, 'int16');
        fread(fid, 1, 'int32');
        
        
        % сеточный объект
        if chunk_id == 16640
            
            iobject = iobject + 1;
            
            objects(iobject).name = name;
            
            %Чтение граней
            chunk_id = fread(fid, 1, 'int16');
            chunk_len = fread(fid, 1, 'int32');
            FF = ftell(fid) + chunk_len - 6;

            if chunk_id == 16656
                % Чтение верщин
                N = fread(fid, 1, 'int16');
                
                Vertexes = zeros(N, 3);
                for i = 1 : N
                  Vertexes(i, 1) = scale * fread(fid, 1, 'float32');
                  Vertexes(i, 2) = scale * fread(fid, 1, 'float32');
                  Vertexes(i, 3) = scale * fread(fid, 1, 'float32');
                end
                
            end
            
            %информация о гранях
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
    
    
    % переходим к следующему объекту в сцене
    fseek(fid, fposNextObject, 'bof');
    chunk_id = fread(fid, 1, 'int16');
    chunk_len = fread(fid, 1, 'int32');
    fposNextObject = ftell(fid) + chunk_len - 6;
end

% закрываем файл
fclose(fid);