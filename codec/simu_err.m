report_base=fileread('DNAlen_0717_e.txt'); %����ȫ��
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
words(cellfun(@isempty,words))=[];
for i=1:12
    err_pro=0.01;
    rongyu=30/176;%ÿ��DNA���е�����
    err_pro_num=round(err_pro*size(report_base,2));
    y=randsample(1:size(report_base,2),err_pro_num);%�����������ģ������λ��
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
    if randsample(1:round(size(report_base,2)/zongcishu),1)==1%���Ʒָ���GG��ѡ�еĸ���
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