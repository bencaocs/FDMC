clear
[~,txt,~]=xlsread('results_newcipin_PAP_0715.xls');
%report=fileread('test.txt'); %¶ÁÈëÈ«ÎÄ
report=('for Mrs. Long has just been here');
coding=random_coding(txt,report);
