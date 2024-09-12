report_base=fileread('DNAlen_0717_e.txt'); %读入全文
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
words(cellfun(@isempty,words))=[];
for i=1:12
    err_pro=0.01;
    rongyu=30/176;%每条DNA序列的冗余
    err_pro_num=round(err_pro*size(report_base,2));
    y=randsample(1:size(report_base,2),err_pro_num);%生成随机数，模拟错误的位置
    y_flag=0;
    for k=1:size(y,2)
        for f=1:k-1
            if abs(y(k)-y(f))<5
                y_flag=y_flag+1;
            end
        end
    end
    cuowu_num=size(y,2)-y_flag/2;
    for j=1:cuowu_num
        if randsample(1:176,1)<31
            cuowu_num=cuowu_num-1;
        end
    end
    zongcishu=size(words,1);
    if randsample(1:round(size(report_base,2)/zongcishu),1)==1%估计分隔符GG被选中的概率
        cuowu_pro=1-cuowu_num*2/zongcishu;
    else
       cuowu_pro=1-cuowu_num*1/zongcishu; 
    end
    if i==1
        cuowu_pro_1list=cuowu_pro;
    else
        cuowu_pro_1list=[cuowu_pro_1list cuowu_pro];
    end
end