
clear;
[~,txt,~]=xlsread('ATduo_GGin_base2.xlsx');
report=fileread('pride and prejudice.txt'); %����ȫ��

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
jishu=1;
data=importdata('DNAlen_0717_e.txt');%������
datachar=char(data(1));
for i=size(char(data(1)),2)-2:-1:1
    if strcmp(datachar(i:i+1),'GG')==1%Ѱ��GGG ���зָ�
        if jishu==1
            jishu=i+1;
            datachar(i:i+1)='-';
        else
            jishu=[jishu i+1];
            datachar(i:i+1)='-';
        end

    end
end 
G_son=strsplit(datachar,'-');%����GG�ָ���Ӵ�
out_word=[];
s2={32};
failed_size=0
for j=1:size(G_son,2)
    for g=1:size(txt(1:size(anssor,1)),1)
        if strcmp(char(G_son(j)),char(txt(g,:)))==1%˵�����ڻ��������һ�����滹��

            current_word=char(anssor(g,1));
            %disp([current_word]);
            out_word=strcat(out_word,s2,current_word);
%             base_son=base_son(k+2:size(base_son,2));
% 
%             words_son=out_word;
        else
            failed_size=failed_size+1;%����ʧ�ܵĴ���

        end

    end
end
aaa1=regexprep(char(out_word),' ([\.,?!,;])','$1');
report=regexprep(aaa1,' e e ','\n');%֮ǰ�������س��� e e ,���ڻ�����
report=regexprep(report,' e ','\n');%֮ǰ�Ļس��� e ,���ڻ�����
dlmwrite('PAP_decode_20220717.txt',report,'%10.0f');