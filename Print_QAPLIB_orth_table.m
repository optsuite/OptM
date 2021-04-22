function Print_QAPLIB_orth_table

clc
close all;
% clear all

% data file
src = '/home/wenzw/code/ConvexOpt/SDP/QAPLIB/';
Probname = { 'bur26a',  'bur26b',  'bur26c',  'bur26d',  'bur26e',  'bur26f',  ... % 1 -- 6
    'bur26g',  'bur26h',  'chr12a',  'chr12b',  'chr12c',  'chr15a',  ... % 7 -- 12
    'chr15b',  'chr15c',  'chr18a',  'chr18b',  'chr20a',  'chr20b',  ... % 13 -- 18
    'chr20c',  'chr22a',  'chr22b',  'chr25a',  'els19',  'esc128',  ... % 19 -- 24
    'esc16a',  'esc16b',  'esc16c',  'esc16d',  'esc16e',  'esc16f',  ... % 25 -- 30
    'esc16g',  'esc16h',  'esc16i',  'esc16j',  'esc32a',  'esc32b',  ... % 31 -- 36
    'esc32c',  'esc32d',  'esc32e',  'esc32g',  'esc32h',  'esc64a',  ... % 37 -- 42
    'had12',  'had14',  'had16',  'had18',  'had20',  'kra30a',  ... % 43 -- 48
    'kra30b',  'kra32',  'lipa20a',  'lipa20b',  'lipa30a',  'lipa30b',  ... % 49 -- 54
    'lipa40a',  'lipa40b',  'lipa50a',  'lipa50b',  'lipa60a',  'lipa60b',  ... % 55 -- 60
    'lipa70a',  'lipa70b',  'lipa80a',  'lipa80b',  'lipa90a',  'lipa90b',  ... % 61 -- 66
    'nug12',  'nug14',  'nug15',  'nug16a',  'nug16b',  'nug17',  ... % 67 -- 72
    'nug18',  'nug20',  'nug21',  'nug22',  'nug24',  'nug25',  ... % 73 -- 78
    'nug27',  'nug28',  'nug30',  'rou12',  'rou15',  'rou20',  ... % 79 -- 84
    'scr12',  'scr15',  'scr20',  'sko100a',  'sko100b',  'sko100c',  ... % 85 -- 90
    'sko100d',  'sko100e',  'sko100f',  'sko42',  'sko49',  'sko56',  ... % 91 -- 96
    'sko64',  'sko72',  'sko81',  'sko90',  'ste36a',  'ste36b',  ... % 97 -- 102
    'ste36c',  'tai100a',  'tai100b',  'tai10a',  'tai10b',  'tai12a',  ... % 103 -- 108
    'tai12b',  'tai150b',  'tai15a',  'tai15b',  'tai17a',  'tai20a',  ... % 109 -- 114
    'tai20b',  'tai256c',  'tai25a',  'tai25b',  'tai30a',  'tai30b',  ... % 115 -- 120
    'tai35a',  'tai35b',  'tai40a',  'tai40b',  'tai50a',  'tai50b',  ... % 121 -- 126
    'tai60a',  'tai60b',  'tai64c',  'tai80a',  'tai80b',  'tho150',  ... % 127 -- 132
    'tho30',  'tho40',  'wil100',  'wil50'};  ... % 133 -- 136
    
% % problems whose size is <= 40
% Probname = {'bur26a', 'bur26b', 'bur26c', 'bur26d', 'bur26e', 'bur26f', 'bur26g', 'bur26h', ...  % 1-8
%                     'chr12a', 'chr12b', 'chr12c', 'chr15a', 'chr15b', 'chr15c', 'chr18a', 'chr18b', ...  %9-16
%                     'chr20a', 'chr20b', 'chr20c', 'chr22a', 'chr22b', 'chr25a', ... %17-22
%                     'els19', 'esc16a', 'esc16b', 'esc16c', 'esc16d', 'esc16e', 'esc16f', ...  %23-29
%                     'esc16g', 'esc16h', 'esc16i', 'esc16j', 'esc32a', 'esc32b', 'esc32c', ... %30-36
%                     'esc32d', 'esc32e', 'esc32g', 'esc32h', 'had12', 'had14', 'had16', 'had18', .... %37-44
%                     'had20', 'kra30a', 'kra30b', 'kra32', 'lipa20a', 'lipa20b', 'lipa30a', 'lipa30b', ... %45-52
%                     'lipa40a', 'lipa40b', 'nug12', 'nug14', 'nug15', 'nug16a', 'nug16b', 'nug17', ... %53-60
%                     'nug18', 'nug20', 'nug21', 'nug22', 'nug24', 'nug25', 'nug27', 'nug28', 'nug30', ... %61-69
%                     'rou12', 'rou15', 'rou20', 'scr12', 'scr15', 'scr20', 'ste36a', 'ste36b', 'ste36c', ... %70-78
%                     'tai10a', 'tai10b', 'tai12a', 'tai12b', 'tai15a', 'tai15b', 'tai17a', 'tai20a', 'tai20b', ... %79-87
%                     'tai25a', 'tai25b', 'tai30a', 'tai30b', 'tai35a', 'tai35b', 'tai40a', 'tai40b', 'tho30', 'tho40'}; %88-97

nprob = length(Probname);

% load('results/res_qap_yind20_1', 'perf', 'mulist');
% load('results/res_qap_X1SL', 'perf', 'mulist');
load('results/res_qap_X2SL', 'perf', 'mulist');
perf1 = perf; mulist1 = mulist; nmu1 = length(mulist);

% load('results/res_qap_X2SL', 'perf', 'mulist');
% load('results/res_qap_X1SL', 'perf', 'mulist');
% load('results/res_qap_X1aa', 'perf', 'mulist');
% perf2 = perf; mulist2 = mulist; nmu2 = length(mulist);
% nmu = size(perf,1)/nprob;


for di = 1:nprob
    
    load(strcat(src, Probname{di}, '.mat'), 'n','A','B','obj');
    %read from a single solver    
    [name, stat] = extractInfo(perf1, nmu1, di);
    n = stat(1); mu = stat(2); objf = stat(4); fgap = stat(5);
    tsolve = stat(6); nfe = stat(8); feasi = stat(9) +stat(10);
    tag = ''; if fgap == 0; tag = '$^\dagger$'; end
    fprintf('%3d & %8s %8s & %4d & %12d & %2.1e & %12d & %7.3f & %7.2f & %3d & %2.1e \\\\ \\hline\n', ...
        di, name, tag, n, obj, mu, objf, fgap, tsolve, nfe, feasi);
    
    
%     [name, stat1] = extractInfo(perf1, nmu1, di);
%     [name2, stat2] = extractInfo(perf2, nmu2, di);
%     if strcmp(name,name2) ~= 1; error('not the same file'); end
%     stat = [stat1; stat2];
%     fidx = stat(:,4) >= 0; idx = (sum(stat(:,9:10),2) < 1e-6) & fidx;
%     if all(idx)
%         [aa, pp] = min(stat(:  ,5));
%     elseif any(idx)
%         pp = find(idx);
%     else
%         pp = 1;
%     end
%     stat = stat(pp,:);  
%     
%     n = stat(1); mu = stat(2); objf = stat(4); fgap = stat(5);
%     tsolve = stat(6); nfe = stat(8); feasi = stat(9) +stat(10);
%     tag = sprintf('$^%d$',pp); if fgap == 0; tag = sprintf('$^{%d\\dagger}$',pp); end
%     
%     fprintf('%3d & %8s %8s & %4d & %12d & %2.1e & %12d & %7.3f & %7.2f & %3d & %2.1e \\\\ \\hline\n', ...
%         di, name, tag, n, obj, mu, objf, fgap, tsolve, nfe, feasi);
%     

end

    function [name, stat] = extractInfo(perf, nmu, di)
        dp = (di-1)*nmu + 1; name = perf{dp+nmu-1,1};
        for dmu = 1:nmu
            stat(dmu,:) =  perf{dp+dmu-1,3};
            %if obj == 0
            %    objf = stat(dmu,4);
            %    stat(dmu,5) = (abs(objf-obj)/max(1,objf))*100;
            %end
            %fprintf('name: %8s, n: %4d, mu: %3.2e, opt: %10d, fobj: %10d, fgap: %6.3f, cpu: %7.2f, itr: %3d, nfe: %3d, feasi: (%2.1e, %2.1e)\n', ...
            %   name, perf{dp,3});
            %dp = dp + 1;
            
            %         perf{dp,1} = name;
            %         if max(feasi1,feasi2)<1e-3;  perf{dp,2} = sparse(X); end
            %         perf{dp,3} = [n, mu, obj, objf, fgap, tsolve,  out.itr,  out.nfe, feasi1, feasi2];
        end
        fidx = stat(:,4) >= 0; idx = (sum(stat(:,9:10),2) < 1e-6) & fidx;
        if any(idx)
            stat = stat(idx,:);
        else
            if ~any(fidx); fidx(1) = 1; end
            stat = stat(fidx,:);
        end
        [aa, pp] = min(stat(:  ,5));
        stat = stat(pp,:);
    end

end
