
% sitenames_first=fileread('Copy_of_test.txt'); %读入全文
% sitename=fileread('test.txt'); %读入全文
function erro_rate = erro_rate_fun(sitenames_first,sitename)
report3=sitenames_first;
report3=regexprep(report3,'\W',' '); %不是字符的，都转换为空格。主要是去除标点符号
report3=lower(report3); %变成小写
words3=regexp(report3,' ','split')'; %根据空格分隔为单词cell
%至此每个单词都拿出来了
rank3 = tabulate(words3); %rank是三列向量，包括名称，出现次数和百分比
anssor3=sortrows(rank3,-2); %只根据第二列进行排序 -2表示降序

report2=sitename; %读入全文
report2=regexprep(report2,'\W',' '); %不是字符的，都转换为空格。主要是去除标点符号
report2=lower(report2); %变成小写
words2=regexp(report2,' ','split')'; %根据空格分隔为单词cell
%至此每个单词都拿出来了
rank2 = tabulate(words2); %rank是三列向量，包括名称，出现次数和百分比
anssor2=sortrows(rank2,-2); %只根据第二列进行排序 -2表示降序
cuowucishu=0;
for i=1:size(anssor2,1)
    if cell2mat(anssor3(i,2))~=cell2mat(anssor2(i,2))
        cuowucishu=cuowucishu+abs(cell2mat(anssor3(i,2))-cell2mat(anssor2(i,2)));
    end
end
erro_rate=(cuowucishu+size(anssor2,1)-size(anssor3,1))*0.7/size(sitenames_first,2);
end


