function DNAlen=random_coding(Cipin,txtfile)
%预编码过程，在编码过程中，。
%当当前由两个单词编码的碱基序列出现有两种解码方式时，对单词对应的寡核苷酸进行更换，当然为了保证存储密度，
%更换只发生在同等长度的寡核苷酸之间。更换完成后，重新开始全文的编码，所有每两个单词组成的单词块都满足单一解的情况时，
%输出编码结果和更新后的字典。
b=0;
txtall=Cipin;
report=txtfile;
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
%xlswrite('PAP_cipin',anssor);%输出为excel文件
txt=txtall(1:size(anssor,1));
new_cell=txt;
hunxiao_list=[];
words(cellfun(@isempty,words))=[];%删除cell中的空元素
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
%对编码结果进行判断，在每两次单词向碱基的映射过程完成后，对上述提到的同一段碱基有多解的情况进行判断

%如存在多解，对EXCEL词典表中的元素进行随机交换
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
    %xlswrite('results_newcipin_PAP_0715',new_cell);%输出为excel文件
    dlmwrite('DNA_random_1.txt',DNAlen,'%10.0f')
    return
end

end
