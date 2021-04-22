function check_QAP_solu

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
    

di = 1;
perm = [26 15 11 7 4 12 13 2 6 18 1 5 9 21 8 14 3 20 19 25 17 10 16 24 23 22];

di = 2;
perm = [17 11 26 7 4 14 6 22 23 18 5 9 1 21 8 12 3 19 20 15 10 25 24 16 13 2];

name = Probname{di};
load(strcat(src, name, '.mat'), 'n','A','B','obj');

% norm(A-A','fro')
% norm(B-B','fro')

% return
X = zeros(n);
for di = 1:n
   X(di,perm(di)) = 1; 
end

[row, col, v] = find(X'); row'-perm

norm(X'*X - eye(n))
trace(A'*X*B*X')
trace(X'*A'*X*B)
% trace(A*X*B*X')
f = 0;
for di = 1:n
    for dj = 1:n
        f = f + A(di,dj)*B(perm(di),perm(dj));
    end
end
f

