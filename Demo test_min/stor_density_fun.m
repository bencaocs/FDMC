function [bianma_midu,jiamiqian_midu,AES_midu,yasuo_midu] = stor_density_fun(Cipin,txtfile,size_ci)
%STOR_DENSITY_FUN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%����ɸѡ���DNA�Ѻ���������ʹ�Ƶģ��洢���ܶ�
%��Ҫ�����Ƶ���ļ���С

%[A,txtx,]=xlsread('PAP_cipin.xls');

txtall=Cipin;
report=txtfile;
report=regexprep(report,'\W',' '); %�����ַ��ģ���ת��Ϊ�ո���Ҫ��ȥ��������
report=lower(report); %���Сд
words=regexp(report,' ','split')'; %���ݿո�ָ�Ϊ����cell
%����ÿ�����ʶ��ó�����
rank = tabulate(words); %rank�������������������ƣ����ִ����Ͱٷֱ�
anssor=sortrows(rank,-2); %ֻ���ݵڶ��н������� -2��ʾ����
%xlswrite('PAP_cipin',anssor);%���Ϊexcel�ļ�
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
sum_ci=sum(cell2mat(A(:,2)));%�ܴ���
%size_ci=298942;%�ֽ���
unique_ci=2228;%��ͬ����
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

base_sum=a+sum_ci*2-2;%���ϳ䵱�������G���
base_width=size(txt,1);%�ʵ������
base_sum=floor(base_sum/146)*(176+8);%�����ص����ֵ�30�����  8����λ��RS
bianma_midu=size_ci*8/base_sum;%������ʵ��  �����ܶ�
jiamiqian_size=(size(ci_list,2)+size(base_list,2)+size(txt,1)*2)*8;%��λ��bit ͨ���ʵ��м���ĸ������ʵ���ĸ���Ϳո����
jiamiqian_midu=size_ci*8/(base_sum+jiamiqian_size/1.6);%����ǰ���ܶ�
%AES���ܺ�Ľ���д����һ����64λ��һ����32λ  ����ͨ��������е���������AES���ܺ��ļ��Ĵ�С
%AES_size=base_width*(32+64+4)/2*8;%��λ��bit
AES_size=(base_width*32*0.52+base_width*64*0.48+base_width*2)*8;
AES_midu=size_ci*8/(base_sum+AES_size/1.6);%�ʵ�����ܶ�Ϊ1.6�����������ϵͳ��Ԥ���ܶ�
%ѹ���ʹ���Ϊ0.5733  ��ѹ����/ԭʼ�ļ�=0.5733
yasuo_midu=size_ci*8/(base_sum+AES_size/1.6*0.5733);%�ʵ�����ܶ�Ϊ1.6�����������ϵͳ��Ԥ���ܶ�

end

