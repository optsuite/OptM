function print_qap_probname

Probname = {'bur26a', 'bur26b', 'bur26c', 'bur26d', 'bur26e', 'bur26f', 'bur26g', 'bur26h', ... %1- 8
    'chr12a', 'chr12b', 'chr12c', 'chr15a', 'chr15b', 'chr15c', 'chr18a', 'chr18b', ... % 9-16
    'chr20a', 'chr20b', 'chr20c', 'chr22a', 'chr22b', 'chr25a', ... %17-22
    'els19', 'esc128', 'esc16a', 'esc16b', 'esc16c', 'esc16d', ... % 23-28
    'esc16e', 'esc16f', 'esc16g', 'esc16h', 'esc16i', 'esc16j', ... %29-34
    'esc32a', 'esc32b', 'esc32c', 'esc32d', 'esc32e', 'esc32g', ... %35-40
    'esc32h', 'esc64a', 'had12',  'had14', 'had16',   'had18', ... %41-46
    'had20', 'kra30a',  'kra30b', 'kra32', 'lipa20a', 'lipa20b', ... %47-52
    'lipa30a', 'lipa30b', 'lipa40a', 'lipa40b', 'lipa50a', 'lipa50b', ... %53-58
    'lipa60a', 'lipa60b', 'lipa70a', 'lipa70b', 'lipa80a', 'lipa80b', ... %59-64
    'lipa90a', 'lipa90b',  'nug12',  'nug14', 'nug15', 'nug16a', ...      %65-70
    'nug16b', 'nug17',   'nug18', 'nug20', 'nug21', 'nug22', ...        %71-76
    'nug24', 'nug25', 'nug27', 'nug28', 'nug30', 'rou12', ...   %77 -82
    'rou15', 'rou20', 'scr12', 'scr15', 'scr20', 'sko100a', ... %83-88
    'sko100b', 'sko100c', 'sko100d', 'sko100e', 'sko100f', 'sko42', ... %89-94
    'sko49', 'sko56', 'sko64', 'sko72', 'sko81', 'sko90', 'ste36a', 'ste36b', 'ste36c', 'tai100a', 'tai100b', 'tai10a', 'tai10b', 'tai12a', 'tai12b', 'tai150b', 'tai15a', ...
    'tai15b', 'tai17a', 'tai20a', 'tai20b', 'tai256c', 'tai25a', 'tai25b', 'tai30a', 'tai30b', 'tai35a', 'tai35b', 'tai40a', 'tai40b', 'tai50a', ...
    'tai50b', 'tai60a', 'tai60b', 'tai64c', 'tai80a', 'tai80b', 'tho150', 'tho30', 'tho40', 'wil100', 'wil50'};  %

Probname = {'brock200_1', 'brock200_2', 'brock200_3', 'brock200_4', 'brock400_1', 'brock400_2', 'brock400_3', 'brock400_4', 'brock800_1', 'brock800_2', 'brock800_3', 'brock800_4', 'c-fat200-1', 'c-fat200-2', 'c-fat200-5', 'c-fat500-10', 'c-fat500-1', 'c-fat500-2', 'c-fat500-5', 'hamming10-2', 'hamming10-4', 'hamming6-2', 'hamming6-4', 'hamming8-2', 'hamming8-4', 'johnson16-2-4', 'johnson32-2-4', 'johnson8-2-4', 'johnson8-4-4', 'keller4', 'keller5', 'keller6', 'MANN_a27', 'MANN_a45', 'MANN_a81', 'MANN_a9', 'p_hat1000-1', 'p_hat1000-2', 'p_hat1000-3', 'p_hat1500-1', 'p_hat1500-2', 'p_hat1500-3', 'p_hat300-1', 'p_hat300-2', 'p_hat300-3', 'p_hat500-1', 'p_hat500-2', 'p_hat500-3', 'p_hat700-1', 'p_hat700-2', 'p_hat700-3', 'san1000', 'san200_0.7_1', 'san200_0.7_2', 'san200_0.9_1', 'san200_0.9_2', 'san200_0.9_3', 'san400_0.5_1', 'san400_0.7_1', 'san400_0.7_2', 'san400_0.7_3', 'san400_0.9_1', 'sanr200_0.7', 'sanr200_0.9', 'sanr400_0.5', 'sanr400_0.7'};

Probname = {  'MANN_a9',  'MANN_a27',  'MANN_a45',  'MANN_a81',  ...
 'brock200_1',  'brock200_2',  'brock200_3',  'brock200_4',  'brock400_1',  'brock400_2',  ... % 1 -- 6
 'brock400_3',  'brock400_4',  'brock800_1',  'brock800_2',  'brock800_3',  'brock800_4',  ... % 7 -- 12
 'c-fat200-1',  'c-fat200-2',  'c-fat200-5',  'c-fat500-1',  'c-fat500-2',  'c-fat500-5', 'c-fat500-10',   ... % 13 -- 18
  'hamming6-2',  'hamming6-4',  'hamming8-2',  ... % 19 -- 24
 'hamming8-4','hamming10-2',  'hamming10-4',    'johnson8-2-4',  'johnson8-4-4', 'johnson16-2-4',  'johnson32-2-4', 'keller4',  ... % 25 -- 30
 'keller5',  'keller6',    ... % 31 -- 36
 'p_hat300-1',  'p_hat300-2',  'p_hat300-3',  'p_hat500-1',  'p_hat500-2',  'p_hat500-3',  ... % 43 -- 48
 'p_hat700-1',  'p_hat700-2',  'p_hat700-3', ... 
 'p_hat1000-1',  'p_hat1000-2',  'p_hat1000-3',  'p_hat1500-1',  'p_hat1500-2',  'p_hat1500-3',  ... % 37 -- 42
  'san200_0.7_1',  'san200_0.7_2', 'san200_0.9_1',  'san200_0.9_2',  'san200_0.9_3',  'san400_0.5_1',  'san400_0.7_1',  'san400_0.7_2',  ... % 55 -- 60
 'san400_0.7_3',  'san400_0.9_1', 'san1000', 'sanr200_0.7',  'sanr200_0.9',  'sanr400_0.5',  'sanr400_0.7' }; ... % 61 -- 66


% Probname ={'theta4', 'theta42',  'theta6',  'theta62',   'theta8',   'theta82',  'theta83', 'theta10', 'theta102',...  %1- 9
%     'theta103', 'theta104',  'theta12',   'theta123','theta32', ...     %10-14
%     'MANN-a27', 'johnson8-4-4', 'johnson16-2-4', 'san200-0.7-1', 'sanr200-0.7', 'c-fat200-1', ...  %15-20
%     'hamming-6-4', 'hamming-7-5-6', 'hamming-8-3-4', 'hamming-8-4', ...  %21-24
%     'hamming-9-5-6', 'hamming-9-8', 'hamming-10-2', 'brock200-1', 'brock200-4', 'brock400-1', ...  %25-30
%     'keller4', 'p-hat300-1', 'G43', 'G44', 'G45', 'G46', 'G47', 'G51', 'G52', 'G53', 'G54', ...  %31-41
%     '1dc.64', '1et.64', '1tc.64',  ...                  % 1-3
%     '1dc.128', '1et.128', '1tc.128', '1zc.128', '2dc.128',  ... % 4-8
%     '1dc.256', '1et.256',  '1tc.256', '1zc.256', '2dc.256', ...  % 9-13
%     '1dc.512', '1et.512', '1tc.512',  '1zc.512', '2dc.512', ...  % 14-18
%     '1dc.1024', '1et.1024',  '1tc.1024',  '1zc.1024', '2dc.1024', ... %19-23
%     '1dc.2048', '1et.2048',    '1tc.2048',  '1zc.2048',  '2dc.2048'}; %24-28

Probname = {'DSJC1000-1','DSJC1000-5','DSJC1000-9','DSJC125-1','DSJC125-5','DSJC125-9','DSJC250-1','DSJC250-5','DSJC250-9','DSJC500-1','DSJC500-5','DSJC500-9','DSJR500-1c','DSJR500-1','DSJR500-5','flat1000-50-0','flat1000-60-0','flat1000-76-0','flat300-20-0','flat300-26-0','flat300-28-0','fpsol2-i-1','fpsol2-i-2','fpsol2-i-3','inithx-i-1','inithx-i-2','inithx-i-3','latin-square-10','le450-15a','le450-15b','le450-15c','le450-15d','le450-25a','le450-25b','le450-25c','le450-25d','le450-5a','le450-5b','le450-5c','le450-5d','mulsol-i-1','mulsol-i-2','mulsol-i-3','mulsol-i-4','mulsol-i-5','school1','school1-nsh','zeroin-i-1','zeroin-i-2','zeroin-i-3'};

Probname = {'band_n200_m100_w0'; 'band_n200_m100_w1'; 'band_n200_m100_w2'; 'band_n200_m100_w4'; 'band_n200_m100_w8'; 'band_n200_m100_w16'; 'band_n200_m100_w32'; 'band_n100_m100_w5'; 'band_n200_m100_w5'; 'band_n400_m100_w5'; 'band_n800_m100_w5'; 'band_n1600_m100_w5'; 'band_n500_m10_w3'; 'band_n500_m50_w3'; 'band_n500_m100_w3'; 'band_n500_m200_w3'; 'band_n500_m400_w3'; 'band_n500_m800_w3'; 'mtxnorm_p90_q10_r100'; 'mtxnorm_p190_q10_r100'; 'mtxnorm_p390_q10_r100'; 'mtxnorm_p790_q10_r100'; 'mtxnorm_p1590_q10_r100'; 'mtxnorm_p400_q10_r200_d1'; 'mtxnorm_p400_q10_r200_d5'; 'mtxnorm_p400_q10_r200_d10'; 'mtxnorm_p400_q10_r200_d20'; 'mtxnorm_p400_q10_r200_d50'; 'mtxnorm_p400_q10_r200_d100'; 'mtxnorm_p400_q10_r200_d250'; 'mtxnorm_p400_q10_r200_d500'; 'mtxnorm_p400_q10_r50'; 'mtxnorm_p400_q10_r100'; 'mtxnorm_p400_q10_r200'; 'mtxnorm_p400_q10_r400'; 'mtxnorm_p400_q10_r800'; 'mtxnorm_p999_q1_r10'; 'mtxnorm_p998_q2_r10'; 'mtxnorm_p995_q5_r10'; 'mtxnorm_p990_q10_r10'; 'mtxnorm_p980_q20_r10'; 'mtxnorm_p950_q50_r10'; 'cliqueoverlap_N16_u0_m100'; 'cliqueoverlap_N16_u1_m100'; 'cliqueoverlap_N16_u2_m100'; 'cliqueoverlap_N16_u4_m100'; 'cliqueoverlap_N16_u8_m100'; 'cliqueoverlap_N16_u15_m100'; 'rs35'; 'rs200'; 'rs228'; 'rs365'; 'rs828'; 'rs1184'; 'rs1288'; 'rs1555'; 'rs1907'};

Probname ={'DSJC1000.1', 'DSJC1000.5', 'DSJC1000.9', 'DSJC125.1', 'DSJC125.5', 'DSJC125.9', 'DSJC250.1', 'DSJC250.5', 'DSJC250.9', 'DSJC500.1', 'DSJC500.5', 'DSJC500.9', 'DSJR500.1c', 'DSJR500.1', 'DSJR500.5', 'flat1000_50_0', 'flat1000_60_0', 'flat1000_76_0', 'flat300_20_0', 'flat300_26_0', 'flat300_28_0', 'fpsol2.i.1', 'fpsol2.i.2', 'fpsol2.i.3', 'inithx.i.1', 'inithx.i.2', 'inithx.i.3', 'latin_square_10', 'le450_15a', 'le450_15b', 'le450_15c', 'le450_15d', 'le450_25a', 'le450_25b', 'le450_25c', 'le450_25d', 'le450_5a', 'le450_5b', 'le450_5c', 'le450_5d', 'mulsol.i.1', 'mulsol.i.2', 'mulsol.i.3', 'mulsol.i.4', 'mulsol.i.5', 'school1', 'school1_nsh', 'zeroin.i.1', 'zeroin.i.2', 'zeroin.i.3', 'anna', 'david', 'homer', 'huck', 'jean', 'games120', 'miles1000', 'miles1500', 'miles250', 'miles500', 'miles750', 'queen10_10', 'queen11_11', 'queen12_12', 'queen13_13', 'queen14_14', 'queen15_15', 'queen16_16', 'queen5_5', 'queen6_6', 'queen7_7', 'queen8_12', 'queen8_8', 'queen9_9', 'myciel3', 'myciel4', 'myciel5', 'myciel6', 'myciel7'};

Probname ={'Andrews', 'apache1', 'bundle1', 'C60', 'c_65', 'cbuckle', 'cfd1', 'copter1', 'ct20stif', 'F2', 'finan512', 'Ga10As10H30', 'Ga19As19H42', 'Ga3As3H12', 'GaAsH6', 'msc23052', 'nd12k', 'obstclae', 'OPF_3754', 'shallow_water1', 'Si10H16', 'Si34H36', 'Si5H12', 'SiH4', 'SiO', 'torsion1', 'vanbody', 'wathen100'};

np = 4; pp = 1; 
nlen = length(Probname);
for di = 1:nlen
    name = Probname{di};
    fprintf(' ''%s'', ', name);
    %fprintf(' ''%s'', ',strrep(strrep(name,'.','-'),'_','-'));
    if mod(di, np) == 0 || di == nlen
       fprintf(' ... %% %d -- %d\n', pp, di);
       pp = pp + np;
    end
    
end
