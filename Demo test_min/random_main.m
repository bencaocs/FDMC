
%˼·�����Ĵ�Ƶͳ���漰���ԡ�������жϣ���Ҫ����ʵ���д�жϹ��򣬺ܸ��ӡ�
%��򵥵İ취��ֱ��ͳ��Ӣ�Ĵ�Ƶ�����ɿո�ֱ�ӻ��ִ��Ȼ���ٷ��뼴�ɵõ����Ĵ�Ƶ��
 
clc;
clear;
% [~,txt,~]=xlsread('ATduo_GGin_base2.xlsx');
report=fileread('test.txt'); %����ȫ��
[~,txt,~]=xlsread('results_newcipin_PAP_0715.xls');
%report=fileread('test.txt'); %����ȫ��
random_txt=('A single man of large fortune');

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
txt=txt(1:size(anssor,1));
words(cellfun(@isempty,words))=[];
%xlswrite('results',anssor);%���Ϊexcel�ļ�

%random�ʵķִ�
random_txt=regexprep(random_txt,'\n',' e ');%�س�����*
random_txt=regexprep(random_txt,'([\.,?!,;])',' $1'); %�ڡ���������ǰ�ӿո�׼����һ��ɾ����������
% report1=regexprep(report,'(?='\W')^.',' .');%(?=test)expr ͬʱ�� test �� expr ƥ�䡣�� (?=[a-z])[^aeiou] �븨��ƥ�䡣
random_txt=regexprep(random_txt,'[^a\.,?!,;-zA-Z_0-9]',' ');
random_txt=lower(random_txt); %���Сд

words_random=regexp(random_txt,' ','split')'; %���ݿո�ָ�Ϊ����cell
%����ÿ�����ʶ��ó�����

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
data1=importdata('DNA_txt_1.txt');%����DNA����
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


lian=1;%�����������
jishu=1;
if j==1
    data_random_decode=data_random_base;%������
end
%length(char(data(1)))
datachar=data_random_decode;
for i=1:size(data_random_decode,2)-lian
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
    txt_all=random_Decode_fun(base_son,txt,anssor,k_max);
end
out_word_test=fileread('random_txt_1.txt'); %����ȫ��
report_test=regexprep(out_word_test,' ([\.,?!,;])','$1');
%report_test=regexprep(aaa1,' e e ','\n');%֮ǰ�������س��� e e ,���ڻ�����
report_test=regexprep(report_test,' e ','\n');%֮ǰ�Ļس��� e ,���ڻ�����
dlmwrite('random_txt_output.txt',report_test,'%10.0f');


%˳����һ�´洢�ܶ�
fidd = fopen('test.txt');
fseek(fidd,0,'eof');
fsize = ftell(fidd); %fsize�����ļ���С��
fclose(fidd);
[bianma_midu,jiamiqian_midu,~,~]=stor_density_fun(txt,report,fsize);