function [bianma_midu,jiamiqian_midu,AES_midu,yasuo_midu] = stor_density_fun(Cipin,txtfile,size_ci)
%STOR_DENSITY_FUN 此处显示有关此函数的摘要
%   此处显示详细说明
%根据筛选后的DNA寡核苷酸个数和词频模拟存储的密度
%需要输入词频和文件大小

%[A,txtx,]=xlsread('PAP_cipin.xls');

txtall=Cipin;
report=txtfile;
report=regexprep(report,'\W',' '); %不是字符的，都转换为空格。主要是去除标点符号
report=lower(report); %变成小写
words=regexp(report,' ','split')'; %根据空格分隔为单词cell
%至此每个单词都拿出来了
rank = tabulate(words); %rank是三列向量，包括名称，出现次数和百分比
anssor=sortrows(rank,-2); %只根据第二列进行排序 -2表示降序
%xlswrite('PAP_cipin',anssor);%输出为excel文件
txt=txtall(1:size(anssor,1));
A=anssor;
flag_i=1;
num_len=size(cell2mat(txt(1)),2);
for i=1:size(txt,1)
    if num_len<size(cell2mat(txt(i)),2)
        flag_len=num_len-1;
        num_len=size(cell2mat(txt(i)),2);
        if flag_i==1
            DNA_len=i-1;
            flag_i=flag_i+1;
        else
            DNA_len=[DNA_len i-1];
        end
    end
end
DNA_len_list=[DNA_len size(txt,1)];
% for j=1:size(DNA_len_list,2)-1
%     DNA_len_list(j+1)=DNA_len(j+1)-DNA_len(j);
% end
 %DNA_len=[3 6 6 22 34 190 242 1534 1778];
 DNA_len=DNA_len_list;
DNA=1:1:size(DNA_len,2);
sum_ci=sum(cell2mat(A(:,2)));%总词数
%size_ci=298942;%字节数
unique_ci=2228;%不同词数
DNA_len1=sum(cell2mat(A(1:DNA_len(1),2)));
DNA_len_cumsum=cumsum(DNA_len);
for i=1:size(DNA_len,2)-1
    DNA_len2=sum(cell2mat(A(DNA_len(i)+1:DNA_len(i+1),2)));
    DNA_len1=[DNA_len1 DNA_len2];
end
a=DNA_len1*DNA';

for k=1:size(txt,1)
    if k==1
        base_list=cell2mat(txt(1));
        ci_list=cell2mat(A(1,1));
    else
        base_list=[base_list cell2mat(txt(k))];
        ci_list=[ci_list cell2mat(A(k,1))];
    end
end

base_sum=a+sum_ci*2-2;%加上充当间隔符的G碱基
base_width=size(txt,1);%词典的条数
base_sum=floor(base_sum/146)*(176+8);%加上重叠部分的30个碱基  8是两位的RS
bianma_midu=size_ci*8/base_sum;%不计算词典的  编码密度
jiamiqian_size=(size(ci_list,2)+size(base_list,2)+size(txt,1)*2)*8;%单位是bit 通过词典中碱基的个数，词的字母数和空格估算
jiamiqian_midu=size_ci*8/(base_sum+jiamiqian_size/1.6);%加密前的密度
%AES加密后的结果中大概有一半是64位，一半是32位  所以通过碱基序列的条数估计AES加密后文件的大小
%AES_size=base_width*(32+64+4)/2*8;%单位是bit
AES_size=(base_width*32*0.52+base_width*64*0.48+base_width*2)*8;
AES_midu=size_ci*8/(base_sum+AES_size/1.6);%词典编码密度为1.6的情况下整个系统的预估密度
%压缩率估计为0.5733  即压缩后/原始文件=0.5733
yasuo_midu=size_ci*8/(base_sum+AES_size/1.6*0.5733);%词典编码密度为1.6的情况下整个系统的预估密度

end

