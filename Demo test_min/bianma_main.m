% base_list='CGTTGGCTTG';
% a=hunxiao_fun(base_list);
%%%%±àÂë
clear
[~,txt,~]=xlsread('GCduo_Gin_base1.xlsx');
report=fileread('test.txt'); %¶ÁÈëÈ«ÎÄ
coding=fenci_coding(txt,report);



disp([DNAlen]);
disp([DNAduizhao]);
dlmwrite('DNAbase_PAP.txt',DNAlen,'%10.0f')
dlmwrite('DNAduizhao.txt',DNAduizhao,'%10.0f')
fid = fopen('GCduo_Gin_base2.txt','wt+');

fprintf(fid,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d \n',DNAlen);
fclose(fid);