%���ȫ�������Ľ������
clear;
clear global out_word
[~,txt,~]=xlsread('results_newcipin_PAP_0715.xls');
report=fileread('test.txt'); %����ȫ��
lian=1;%�����������
%report=regexprep(report,'\D{3}\d\D*\d\D{3}',' ');% ȥ������   ��  1  ҳ  ��  79  ҳ 
report=regexprep(report,'\n',' e ');%�س�����*
report1=regexprep(report,'([\.,?!,;])',' $1'); %�ڡ���������ǰ�ӿո�׼����һ��ɾ����������
% report1=regexprep(report,'(?='\W')^.',' .');%(?=test)expr ͬʱ�� test �� expr ƥ�䡣�� (?=[a-z])[^aeiou] �븨��ƥ�䡣
report1=regexprep(report1,'[^a\.,?!,;-zA-Z_0-9]',' ');
report1=lower(report1); %���Сд

words=regexp(report1,' ','split')'; %���ݿո�ָ�Ϊ����cell
%����ÿ�����ʶ��ó�����
rank = tabulate(words); %rank�������������������ƣ����ִ����Ͱٷֱ�
anssor=sortrows(rank,-2); %ֻ���ݵڶ��н������� -2��ʾ����
%xlswrite('results',anssor);%���Ϊexcel�ļ� 
txt=txt(1:size(anssor,1));
jishu=1;
data=importdata('DNA_txt_1.txt');%������
%length(char(data(1)))
datachar=char(data(1));
for i=1:size(char(data(1)),2)-lian
    if strcmp(datachar(i:i+lian),'GG')==1%Ѱ��GGG ���зָ�
        if jishu==1
            jishu=i+lian;
            datachar(i+lian)='-';
        else
            jishu=[jishu i+lian];
            datachar(i+lian)='-';
        end

    end
end 
G_son=strsplit(datachar,'-');%����GG�ָ���Ӵ�
k_max=9;
k_min=1;
global word_flag;
word_flag=0;
for j=1:size(G_son,2)
    base_son=char(G_son(j));
    txt_all=Decode_fun(base_son,txt,anssor,k_max);
end
out_word_test=fileread('GCduo_Gin_base1.txt'); %����ȫ��
report_test=regexprep(out_word_test,' ([\.,?!,;])','$1');
%report_test=regexprep(aaa1,' e e ','\n');%֮ǰ�������س��� e e ,���ڻ�����
report_test=regexprep(report_test,' e ','\n');%֮ǰ�Ļس��� e ,���ڻ�����
dlmwrite('PAP_decode_test_2022_7_20.txt',report_test,'%10.0f');



 