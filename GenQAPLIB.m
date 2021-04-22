function GenQAPLIB

clc
close all;
% clear all

doSeDumi  = 0;
doprofile = 1;


% data file


src = '/home/wenzw/code/ConvexOpt/SDP/QAPLIB/';
Probname = {'bur26a', 'bur26b', 'bur26c', 'bur26d', 'bur26e', 'bur26f', 'bur26g', 'bur26h', ...
    'chr12a', 'chr12b', 'chr12c', 'chr15a', 'chr15b', 'chr15c', 'chr18a', 'chr18b', 'chr20a', 'chr20b', 'chr20c', 'chr22a', 'chr22b', 'chr25a', ...
    'els19', 'esc128', 'esc16a', 'esc16b', 'esc16c', 'esc16d', 'esc16e', 'esc16f', 'esc16g', 'esc16h', 'esc16i', 'esc16j', 'esc32a', ...
    'esc32b', 'esc32c', 'esc32d', 'esc32e', 'esc32g', 'esc32h', 'esc64a', 'had12', 'had14', 'had16', 'had18', 'had20', 'kra30a', ...
    'kra30b', 'kra32', 'lipa20a', 'lipa20b', 'lipa30a', 'lipa30b', 'lipa40a', 'lipa40b', 'lipa50a', 'lipa50b', 'lipa60a', 'lipa60b', ...
    'lipa70a', 'lipa70b', 'lipa80a', 'lipa80b', 'lipa90a', 'lipa90b', 'nug12', 'nug14', 'nug15', 'nug16a', 'nug16b', 'nug17',  ...
    'nug18', 'nug20', 'nug21', 'nug22', 'nug24', 'nug25', 'nug27', 'nug28', 'nug30', 'rou12', 'rou15', 'rou20', 'scr12', 'scr15', ... 
    'scr20', 'sko100a', 'sko100b', 'sko100c', 'sko100d', 'sko100e', 'sko100f', 'sko42', 'sko49', 'sko56', 'sko64', 'sko72', ...
    'sko81', 'sko90', 'ste36a', 'ste36b', 'ste36c', 'tai100a', 'tai100b', 'tai10a', 'tai10b', 'tai12a', 'tai12b', 'tai150b', 'tai15a', ...
    'tai15b', 'tai17a', 'tai20a', 'tai20b', 'tai256c', 'tai25a', 'tai25b', 'tai30a', 'tai30b', 'tai35a', 'tai35b', 'tai40a', 'tai40b', 'tai50a', ...
    'tai50b', 'tai60a', 'tai60b', 'tai64c', 'tai80a', 'tai80b', 'tho150', 'tho30', 'tho40', 'wil100', 'wil50'};

info = {'esc32a',130;
'esc32b', 168;
'esc32c', 642;
'esc32d', 200;
'esc32h', 438;
'esc64a', 116;
'sko42',  15812;
'sko49',  23386;
'sko56',  34458;
'sko64',  48498;
'sko72',  66256;
'tai30a', 1818146;
'tai35a', 2422002;
'tai40a', 3139370;
'tho40',  240516;
'wil50',  48816};

% load QAPSDPMATA
% nmax = 40;
% for dn = 1:nmax
%     clear n m ACon b L
%     n = MATA{dn,1};   m = MATA{dn,2};  ACon = MATA{dn,3};  b = MATA{dn,4};  L = MATA{dn,5};
%     
%     save(strcat(src, 'QAPn', num2str(n) ), 'n', 'm', 'ACon', 'b', 'L');
% 
% end

nprob = length(Probname);


Problist = [1:nprob];
% Problist = [2];
% Problist = [nprob];

for di = 1:length(Problist)
    
    name = Probname{Problist(di)};
    file = strcat(src, name,'.dat');
    fid = fopen(file, 'r');

    n = fscanf(fid, '%d', 1);
 
    A = fscanf(fid, '%f', [n, n]);    % It has two rows now.
    A = A';
    
    B = fscanf(fid, '%f', [n, n]);    % It has two rows now.
    B = B';
%     A
%     B
    fclose(fid);
    
    % read solution
    file = strcat(src, name,'.sln');
    fid = fopen(file, 'r');
    if fid > 0
        fscanf(fid, '%d', 1);
        obj = fscanf(fid, '%f', 1);
        [solu, count] = fscanf(fid, '%d', n);    % It has two rows now.

%         if count ~= n
%             obj = 0;
%         end
        fclose(fid);
    

        fprintf('name: %s, n: %d, obj: %d, count: %d\n', name, n, obj, count);

    else
        obj = 0;
        fprintf('name: %s, n: %d, obj: %d\n', name, n, obj);
    end
        
   save(strcat(src, name), 'n', 'A', 'B', 'obj');

end

for di = 1:length(info)
    name = info{di,1};
    load(strcat(src, name), 'n', 'A', 'B', 'obj');
    obj = info{di,2};
    fprintf('name: %s, n: %d, obj: %d\n', name, n, obj);
    save(strcat(src, name), 'n', 'A', 'B', 'obj');
end


fprintf('\n\n');
for di = 1:length(Problist)
    name = Probname{Problist(di)};
    load(strcat(src, name), 'n', 'A', 'B', 'obj');
    fprintf('name: %s, n: %d, obj: %d\n', name, n, obj);
end

% %  print problem whose size is <= 40
% for di = 1:length(Problist)
%     
%     name = Probname{Problist(di)};
%     file = strcat(src, name,'.dat');
%     fid = fopen(file, 'r');
% 
%     n = fscanf(fid, '%d', 1);
%     fclose(fid);
%  
%     if n <= 40
%         fprintf('''%s'', ', name); 
%     end
% 
% end
% 




end
