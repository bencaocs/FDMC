
%思路：中文词频统计涉及到对“词语”的判断，需要导入词典或编写判断规则，很复杂。
%最简单的办法是直接统计英文词频，并由空格直接划分词语。然后再翻译即可得到中文词频。
 
clc;
clear;
% [~,txt,~]=xlsread('ATduo_GGin_base2.xlsx');
report=fileread('test.txt'); %读入全文
[~,txt,~]=xlsread('results_newcipin_PAP_0715.xls');
%report=fileread('test.txt'); %读入全文
random_txt=('A single man of large fortune');

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
txt=txt(1:size(anssor,1));
words(cellfun(@isempty,words))=[];
%xlswrite('results',anssor);%输出为excel文件

%random词的分词
random_txt=regexprep(random_txt,'\n',' e ');%回车换成*
random_txt=regexprep(random_txt,'([\.,?!,;])',' $1'); %在。，？！；前加空格，准备下一步删除其他符号
% report1=regexprep(report,'(?='\W')^.',' .');%(?=test)expr 同时与 test 和 expr 匹配。如 (?=[a-z])[^aeiou] 与辅音匹配。
random_txt=regexprep(random_txt,'[^a\.,?!,;-zA-Z_0-9]',' ');
random_txt=lower(random_txt); %变成小写

words_random=regexp(random_txt,' ','split')'; %根据空格分隔为单词cell
%至此每个单词都拿出来了

for i=1:size(words_random,1)
    if isempty(char(words_random(i,:)))==0
       for j=1:size(anssor,1)
           if strcmp(char(words_random(i,:)),char(anssor(j,1)))==1
%                disp(char(anssor(j,1)));
%                disp(char(txt(j,:)));
               
               quma=char(txt(j,:));
%                if strcmp(quma,'GG')+strcmp(quma,'CT')>0
%                  Aquma=quma;
%                else
%                  Aquma=['G',quma];
%                end
                Aquma=['G',quma];
                Aduizhao=[' ',quma];
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
count=0;
data1=importdata('DNA_txt_1.txt');%导入DNA序列
ATCG=data1;
ATCG=cell2mat(ATCG);
rap_len=length(DNAlen);
for j=1:size(ATCG,1)
    ATCG_curn=ATCG(j,:);
    for i=1:length(ATCG(1,:))-rap_len
        d = EditDist(DNAlen,ATCG_curn(i:rap_len+i-1));
        if d<2
            %disp(j);
            disp(['----over----',ATCG_curn(i:rap_len+i-1)]);
            %data_random_base=ATCG_curn(i:rap_len+i-1);
            for g=1:i-1
                if strcmp(ATCG_curn(i-g:i-g+1),'GG')==1
                    rad_l_base=i-g+2;
                    break
                end
            end
            for f=1:i-1
                if strcmp(ATCG_curn(rap_len+i-1+f:rap_len+i+f),'GG')==1
                    rad_r_base=rap_len+i-1+f;
                    break
                end
            end
            data_random_base=ATCG_curn(rad_l_base:rad_r_base);
        end
        count=count+1;
    end
    %disp(j);
end


lian=1;%连续碱基个数
jishu=1;
if j==1
    data_random_decode=data_random_base;%编码结果
end
%length(char(data(1)))
datachar=data_random_decode;
for i=1:size(data_random_decode,2)-lian
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
    txt_all=random_Decode_fun(base_son,txt,anssor,k_max);
end
out_word_test=fileread('random_txt_1.txt'); %读入全文
report_test=regexprep(out_word_test,' ([\.,?!,;])','$1');
%report_test=regexprep(aaa1,' e e ','\n');%之前的连续回车变 e e ,现在还回来
report_test=regexprep(report_test,' e ','\n');%之前的回车变 e ,现在还回来
dlmwrite('random_txt_output.txt',report_test,'%10.0f');


%顺便算一下存储密度
fidd = fopen('test.txt');
fseek(fidd,0,'eof');
fsize = ftell(fidd); %fsize就是文件大小！
fclose(fidd);
[bianma_midu,jiamiqian_midu,~,~]=stor_density_fun(txt,report,fsize);