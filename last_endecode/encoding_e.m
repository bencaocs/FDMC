
%˼·�����Ĵ�Ƶͳ���漰���ԡ�������жϣ���Ҫ����ʵ���д�жϹ��򣬺ܸ��ӡ�
%��򵥵İ취��ֱ��ͳ��Ӣ�Ĵ�Ƶ�����ɿո�ֱ�ӻ��ִ��Ȼ���ٷ��뼴�ɵõ����Ĵ�Ƶ��
 
clc;
clear;
[~,txt,~]=xlsread('ATduo_GGin_base2.xlsx');
report=fileread('pride and prejudice.txt'); %����ȫ��


%report=regexprep(report,'\D{3}\d\D*\d\D{3}',' ');% ȥ������   ��  1  ҳ  ��  79  ҳ 
report=regexprep(report,'\n',' e ');%�س�����e ��һ�����ʱ���
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

