function words_son =Decode_fun(base_son,txt,anssor,k_max)%函数功能，给与任意长度的ATGC序列，转为对应单词，txt是和anssor对应的碱基子序列
%k_max=size(char(txt),2);%从左到右考虑的最长单碱基长度
k_min=1;
decode_flag=0;
%base_son_size=size(base_son,2);
clear global out_word
global word_flag out_word;
%global fid;


%本函数采用的是从左向右考虑长度从K_max递减
%分为两种情况考虑，1.当前短序列长度大于最长寡核苷酸 即肯定有多个子链，2.当前短序列长度小于最长，可能只有一个子链
s2={32};
for i=1:size(base_son,2)
    if size(base_son,2)>9%短碱基长度大于8
        for k=k_max:-1:k_min
            for g=1:size(txt(1:size(anssor,1)),1)
                if strcmp(base_son(k_min:k),char(txt(g,:)))==1%说明现在还不是最后一个后面还有
                    if k+1<=size(base_son,2)&&strcmp(base_son(k+1),'G')==1%说明现在还不是最后一个后面还有
                        current_word=char(anssor(g,1));
                        disp([current_word]);
                        fid = fopen('E:\A博士小论文\第五篇小论文\模拟实验\last_endecode\GCduo_Gin_base1.txt','a');
                        fprintf(fid,'%s ',current_word);
                        fclose(fid);
                        out_word=strcat(out_word,s2,current_word);
                        base_son=base_son(k+2:size(base_son,2));
                        Decode_fun(base_son,txt,anssor,k_max);
                        words_son=out_word;
                        return
                    end
                end
                if k==size(base_son,2)&&strcmp(base_son(k_min:k),char(txt(g,:)))==1%现在寻找到最后一部分
                    current_word=char(anssor(g,1));
                    disp([current_word]);
                    fid = fopen('E:\A博士小论文\第五篇小论文\模拟实验\last_endecode\GCduo_Gin_base1.txt','a');
                    fprintf(fid,'%s ',current_word);
                    fclose(fid);
                    out_word=strcat(out_word,s2,current_word);
                    words_son=out_word;
                    decode_num=1;
                    return
                end
            end
        end
    else%短碱基长度小于8
        k_min_min=1;
        for k=size(base_son,2):-1:k_min_min
            for g=1:size(txt(1:size(anssor,1)),1)
                if strcmp(base_son(k_min_min:k),char(txt(g,:)))==1%说明现在还不是最后一个后面还有
                    if k+1<=size(base_son,2)&&strcmp(base_son(k+1),'G')==1
                        current_word=char(anssor(g,1));
                        disp([current_word]);
                        fid = fopen('E:\A博士小论文\第五篇小论文\模拟实验\last_endecode\GCduo_Gin_base1.txt','a');
                        fprintf(fid,'%s ',current_word);
                        fclose(fid);
                        if word_flag==0
                            out_word=current_word;
                            word_flag=1;
                        else
                            out_word=strcat(out_word,s2,current_word);
                        end
                        decode_num=1;
                        base_son=base_son(k+2:size(base_son,2));
                        Decode_fun(base_son,txt,anssor,size(base_son,2)-k);
                        words_son=out_word;
                        return
                    end
                end
                if k==size(base_son,2)&&strcmp(base_son(k_min_min:k),char(txt(g,:)))==1%现在寻找到最后一部分
                    current_word=char(anssor(g,1));
                    disp([current_word]);
                    fid = fopen('E:\A博士小论文\第五篇小论文\模拟实验\last_endecode\GCduo_Gin_base1.txt','a');
                    fprintf(fid,'%s ',current_word);
                    fclose(fid);
                    out_word=strcat(out_word,s2,current_word);
                    decode_num=1;
                    decode_flag=1;
                    words_son=out_word;
                    return
                end
            end
        end
    end
end

words_son=out_word;
end