function DNAlen=random_coding(Cipin,txtfile)
%Ԥ������̣��ڱ�������У���
%����ǰ���������ʱ���ļ�����г��������ֽ��뷽ʽʱ���Ե��ʶ�Ӧ�ĹѺ�������и�������ȻΪ�˱�֤�洢�ܶȣ�
%����ֻ������ͬ�ȳ��ȵĹѺ�����֮�䡣������ɺ����¿�ʼȫ�ĵı��룬����ÿ����������ɵĵ��ʿ鶼���㵥һ������ʱ��
%����������͸��º���ֵ䡣
b=0;
txtall=Cipin;
report=txtfile;
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
%xlswrite('PAP_cipin',anssor);%���Ϊexcel�ļ�
txt=txtall(1:size(anssor,1));
new_cell=txt;
hunxiao_list=[];
words(cellfun(@isempty,words))=[];%ɾ��cell�еĿ�Ԫ��
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
                Aquma=['G',quma];
                Aduizhao=[' ',quma];
                if i==1
                    DNAlen=quma;
                    DNAduizhao=quma;
                else
                    DNAlen=[DNAlen Aquma];
                    DNAduizhao=[DNAduizhao Aduizhao];
                    %%%%%
                    mazi_xiaoyan=[mazi_next Aquma];
                    mazi_duizhao=[mazi_next Aduizhao];
                    jiange_flag=find(mazi_duizhao==' ');
                    if ~contains(mazi_xiaoyan,'GG')==0
                        a=0;
                    else
                        a=hunxiao_fun(mazi_xiaoyan,2*size(char(txt(size(txt,1))),2)+1,jiange_flag);
                        b=b+a;
                    end
                    if a==1
                       if b==1
                           hunxiao_list=j;
                           hunxiao_nlist=hunxiao_next;
                       else
                           hunxiao_list=[hunxiao_list j];
                           hunxiao_nlist=[hunxiao_nlist hunxiao_next];
                       end
                       disp(mazi_xiaoyan);
                       disp(mazi_duizhao);

                    end
                    %%%%
                end
                %%%%
                mazi_next=quma;
                hunxiao_next=j;
                
                %%%%
                break;
           end
       end    
    end    

end

%hunxiao_sumlist=unique([hunxiao_list hunxiao_nlist]);
%�Ա����������жϣ���ÿ���ε���������ӳ�������ɺ󣬶������ᵽ��ͬһ�μ���ж�����������ж�

%����ڶ�⣬��EXCEL�ʵ���е�Ԫ�ؽ����������
hunxiao_list=unique(hunxiao_list);
disp(hunxiao_list);
if isempty(hunxiao_list)==0
    x=3;
    if x>3||rand()>0.5
        hunxiao_list=unique(hunxiao_list);
        new_cell=Random_cell(txt,hunxiao_list);
        x=x-1;
    else
        hunxiao_list=unique(hunxiao_list);
        new_cell=Random_cell(txt,hunxiao_nlist);
    end
    %disp(unique(hunxiao_list));
    %disp(size(unique(hunxiao_list),2));
    %new_cell=Random_cell(new_cell,hunxiao_nlist);
    %new_cell=txt;
    %new_cell(hunxiao_list)=[];
    random_coding(new_cell,txtfile);
else
    %xlswrite('results_newcipin_PAP_0715',new_cell);%���Ϊexcel�ļ�
    dlmwrite('DNA_random_1.txt',DNAlen,'%10.0f')
    return
end

end
