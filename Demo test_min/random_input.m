clear
[~,txt,~]=xlsread('results_newcipin_PAP_0715.xls');
%report=fileread('test.txt'); %����ȫ��
report=('for Mrs. Long has just been here');
coding=random_coding(txt,report);
