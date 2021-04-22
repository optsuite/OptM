function TestQAPLIB_orth_fixmu_improve_selected


% clc
close all;
% clear all


% data file
src = '/Users/wenzw/code/ConvexOpt/SDP/QAPLIB/';
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


Problist = [1:nprob];
Problist = [1];     mu = 1e-2;
% Problist = [10];     mu = 1e-2;

% Problist = [nprob];
% Problist = [10:22];
% Problist = [65; 105; 110; 116; 118; 120];
% Problist = [65]; % mu = 1e2
% Problist = [105];
% Problist = [118; 120];
% Problist = [105; 110; 116];
% Problist = [118; 120; 65; 105; 110];
%  Problist = [1:20];
% Problist = [1:20];
% Problist = [1:87];

nrand = 12; % number of random trials

objX = 2;
suffix = 'QQ1';
perf = cell(nprob*nrand,3);
savename = strcat('results/fix_res_qap_X',num2str(objX), suffix);

% objX = 2;
% suffix = 'SL_test';
% perf = cell(nprob*nrand);
% savename = strcat('results/fix_res_qap_X',num2str(objX), suffix);

dp = 1;
for di = 1:length(Problist)
    name = Probname{Problist(di)};
    load(strcat(src, name, '.mat'), 'n','A','B','obj');
   
    for dmu = 1:nrand
        seed = randi(1e8); rand('state',seed);    randn('state',seed);
        % seed = 92395570; rand('state',seed);    randn('state',seed);
        % seed = 43613214; rand('state',seed);    randn('state',seed);
        % seed = 2010; rand('state',seed);    randn('state',seed);
        X0 = randn(n);    X0 = orth(X0);
       
        if dmu <= nrand/3; mu = 1; elseif dmu <= 2*nrand/3; mu = 1e1; else mu = 1e-1; end 
        
        %if dmu <= nrand/3; mu = 1; elseif dmu <= 2*nrand/3; mu = 1e1; else mu = 1e2; end         
        
        %if dmu <= nrand/3; mu = 1; elseif dmu <= 2*nrand/3; mu = 1e1; else mu = 1e2; end 
        
%         if dmu <= nrand/6; mu = 1e-1; 
%         elseif dmu <= 2*nrand/6; mu = 1; 
%         elseif dmu <= 3*nrand/6; mu = 1e-2; 
%         elseif dmu <= 4*nrand/6; mu = 1e1; 
%         elseif dmu <= 5*nrand/6; mu = 1e2; 
%         else mu = 1e3;   end
        
%         if dmu <= nrand/4; mu = 1e1; 
%         elseif dmu <= 2*nrand/4; mu = 1; 
%         elseif dmu <= 3*nrand/4; mu = 1e-1; 
%         else mu = 1e2;   end        
        
        %if dmu <= nrand/3; mu = 1e-1; elseif dmu <= 2*nrand/3; mu = 1e-2; else mu = 1e-3; end 
        %if dmu <= nrand/3; mu = 1e-4; elseif dmu <= 2*nrand/3; mu = 1e-5; else mu = 1e-6; end 
        %mu = 1e6;
        
        %%-----------------------------------------------------------------------
        opts.record = 0;
        
        opts.tol = 1e-3;
        opts.tolsub = 1e-3;
        opts.omxitr  = 100;
        
        opts.mxitr  = 100;
        opts.xtol = 1e-5;
        opts.gtol = 1e-5;
        opts.ftol = 1e-8;
        opts.tau = 1e-3;
        
        opts.objX = objX;
        
        %mu = 1e-2;
        % profile on;
        %tic; [X, out] = QAPORTHAL(X0, A, B, mu, opts);   tsolve = toc;
        %tic; [X, out] = QAPORTHALEQ(X0, A, B, mu, opts);   tsolve = toc;
        tic; [X, out] = QAPORTHALEQQ_QUAD(X0, A, B, mu, opts);   tsolve = toc;
        
        %tic; [X, out]= OptStiefelGBB_V2010_8_20(X0, @qapAB, opts, A, B); tsolve = toc;
        
        %mu = 0.1;
        %tic; [X, out]= OptStiefelGBB(X0, @qapAB_log, opts, A,B,mu); tsolve = toc;
        
        % profile viewer;
        
        X = round(X);
        objf =  qapAB(X,A,B);
        fgap = (abs(objf-obj)/obj)*100;
        if obj==0; fgap = (abs(objf-obj)/max(1,objf))*100; end
        feasi1 = norm(X'*X - eye(n), 'fro');
        feasi2 = norm(sum(X,1)-1)+norm(sum(X,2)-1);
        
        fprintf('%3d, sd: %10d, %8s, n: %4d, mu: %3.2e, opt: %10d, fobj: %10d, fgap: %6.3f, cpu: %7.2f, itr: %3d, nfe: %3d, feasi: %2.1e\n', ...
            dmu, seed, name, n, mu, obj, objf, fgap, tsolve,  out.itr,  out.nfe, feasi1+feasi2 );
        
        perf{dp,1} = name;
        %if max(feasi1,feasi2)<1e-3;  perf{dp,2} = sparse(X); end
        perf{dp,3} = [seed, n, mu, obj, objf, fgap, tsolve,  out.itr,  out.nfe, feasi1, feasi2];
        dp = dp + 1;
       
        if (fgap <= 0.001 || (objf>0 && objf < obj ) ) && objf >= 0 && feasi1+feasi2 <= 1e-7; break; end 
    end
    fprintf('\n\n');
    save(savename, 'perf', 'Problist', 'Probname');    
end

