%碱基全不连续的解码过程
clear;
clear global out_word
[~,txt,~]=xlsread('results_newcipin_PAP_0715.xls');
report=fileread('test.txt'); %读入全文
lian=1;%连续碱基个数
%report=regexprep(report,'\D{3}\d\D*\d\D{3}',' ');% 去除中文   第  1  页  共  79  页 
report=regexprep(report,'\n',' e ');%回车换成*
report1=regexprep(report,'([\.,?!,;])',' $1'); %在。，？！；前加空格，准备下一步删除其他符号
% report1=regexprep(report,'(?='\W')^.',' .');%(?=test)expr 同时与 test 和 expr 匹配。如 (?=[a-z])[^aeiou] 与辅音匹配。
report1=regexprep(report1,'[^a\.,?!,;-zA-Z_0-9]',' ');
report1=lower(report1); %变成小写

words=regexp(report1,' ','split')'; %根据空格分隔为单词cell
%至此每个单词都拿出来了
rank = tabulate(words); %rank是三列向量，包括名称，出现次数和百分比
anssor=sortrows(rank,-2); %只根据第二列进行排序 -2表示降序
%xlswrite('results',anssor);%输出为excel文件 
txt=txt(1:size(anssor,1));
jishu=1;
data=importdata('DNA_txt_1.txt');%编码结果
%length(char(data(1)))
datachar=char(data(1));
for i=1:size(char(data(1)),2)-lian
    if strcmp(datachar(i:i+lian),'GG')==1%寻找GGG 进行分割
        if jishu==1
            jishu=i+lian;
            datachar(i+lian)='-';
        else
            jishu=[jishu i+lian];
            datachar(i+lian)='-';
        end

    end
end 
G_son=strsplit(datachar,'-');%按照GG分割的子串
k_max=9;
k_min=1;
global word_flag;
word_flag=0;
for j=1:size(G_son,2)
    base_son=char(G_son(j));
    txt_all=Decode_fun(base_son,txt,anssor,k_max);
end
out_word_test=fileread('GCduo_Gin_base1.txt'); %读入全文
report_test=regexprep(out_word_test,' ([\.,?!,;])','$1');
%report_test=regexprep(aaa1,' e e ','\n');%之前的连续回车变 e e ,现在还回来
report_test=regexprep(report_test,' e ','\n');%之前的回车变 e ,现在还回来
dlmwrite('PAP_decode_test_2022_7_20.txt',report_test,'%10.0f');



 