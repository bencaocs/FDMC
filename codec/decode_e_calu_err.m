
clear;
[~,txt,~]=xlsread('ATduo_GGin_base2.xlsx');
report=fileread('pride and prejudice.txt'); %读入全文
sitenames_first=report;
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
jishu=1;
data=importdata('DNAlen_0717_e.txt');%编码结果

sequence=char(data(1));
err_pro=0.005;
err_type=3;
for k=1:12    
    new_sequence = err_fun(sequence,err_type,err_pro);
    datachar=new_sequence;
    for i=size(char(data(1)),2)-2:-1:1
        if strcmp(datachar(i:i+1),'GG')==1%寻找GGG 进行分割
            if jishu==1
                jishu=i+1;
                datachar(i:i+1)='-';
            else
                jishu=[jishu i+1];
                datachar(i:i+1)='-';
            end

        end
    end 
    G_son=strsplit(datachar,'-');%按照GG分割的子串
    out_word=[];
    s2={32};
    failed_size=0;
    for j=1:size(G_son,2)
        for g=1:size(txt(1:size(anssor,1)),1)
            if strcmp(char(G_son(j)),char(txt(g,:)))==1%说明现在还不是最后一个后面还有

                current_word=char(anssor(g,1));
                %disp([current_word]);
                out_word=strcat(out_word,s2,current_word);
    %             base_son=base_son(k+2:size(base_son,2));
    % 
    %             words_son=out_word;
    %         else
    %             failed_size=failed_size+1;%解码失败的次数

            end

        end
    end
    aaa1=regexprep(char(out_word),' ([\.,?!,;])','$1');
    report1=regexprep(aaa1,' e e ','\n');%之前的连续回车变 e e ,现在还回来
    report1=regexprep(report1,' e ','\n');%之前的回车变 e ,现在还回来

    %erro_rate = erro_rate_fun(sitenames_first,report1);
    if k==1
        erro_rate = 1-erro_rate_fun(sitenames_first,report1);
        erro_rate_list=erro_rate;
    else
        erro_rate = 1-erro_rate_fun(sitenames_first,report1);
        erro_rate_list=[erro_rate_list erro_rate];
    end
end
disp(erro_rate_list)
