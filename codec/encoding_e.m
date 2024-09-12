
%思路：中文词频统计涉及到对“词语”的判断，需要导入词典或编写判断规则，很复杂。
%最简单的办法是直接统计英文词频，并由空格直接划分词语。然后再翻译即可得到中文词频。
 
clc;
clear;
[~,txt,~]=xlsread('ATduo_GGin_base2.xlsx');
report=fileread('pride and prejudice.txt'); %读入全文


%report=regexprep(report,'\D{3}\d\D*\d\D{3}',' ');% 去除中文   第  1  页  共  79  页 
report=regexprep(report,'\n',' e ');%回车换成e 当一个单词保存
report1=regexprep(report,'([\.,?!,;])',' $1'); %在。，？！；前加空格，准备下一步删除其他符号
% report1=regexprep(report,'(?='\W')^.',' .');%(?=test)expr 同时与 test 和 expr 匹配。如 (?=[a-z])[^aeiou] 与辅音匹配。
report1=regexprep(report1,'[^a\.,?!,;-zA-Z_0-9]',' ');
report1=lower(report1); %变成小写

words=regexp(report1,' ','split')'; %根据空格分隔为单词cell
%至此每个单词都拿出来了
rank = tabulate(words); %rank是三列向量，包括名称，出现次数和百分比
anssor=sortrows(rank,-2); %只根据第二列进行排序 -2表示降序
txt=txt(1:size(anssor,1));
words(cellfun(@isempty,words))=[];
%xlswrite('results',anssor);%输出为excel文件
for i=1:size(words,1)
    if isempty(char(words(i,:)))==0
       for j=1:size(anssor,1)
           if strcmp(char(words(i,:)),char(anssor(j,1)))==1
%                disp(char(anssor(j,1)));
%                disp(char(txt(j,:)));
               
               quma=char(txt(j,:));
%                if strcmp(quma,'GG')+strcmp(quma,'CT')>0
%                  Aquma=quma;
%                else
%                  Aquma=['G',quma];
%                end
                Aquma=['GG',quma];
                Aduizhao=['  ',quma];
                if i==1
                    DNAlen=quma;
                    DNAduizhao=quma;
                else
                    DNAlen=[DNAlen Aquma];
                    DNAduizhao=[DNAduizhao Aduizhao];
                end
                quma_list=quma;
                break;
           end
       end    
    end    

end
disp([DNAlen]);
disp([DNAduizhao]);
dlmwrite('DNAlen_0717_e.txt',DNAlen,'%10.0f')
dlmwrite('DNAduizhao_0717_e.txt',DNAduizhao,'%10.0f')
fid = fopen('ATduo_Ain.txt','wt+');

fprintf(fid,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d \n',DNAlen);
fclose(fid);

