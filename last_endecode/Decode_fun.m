function words_son =Decode_fun(base_son,txt,anssor,k_max)%�������ܣ��������ⳤ�ȵ�ATGC���У�תΪ��Ӧ���ʣ�txt�Ǻ�anssor��Ӧ�ļ��������
%k_max=size(char(txt),2);%�����ҿ��ǵ�����������
k_min=1;
decode_flag=0;
%base_son_size=size(base_son,2);
clear global out_word
global word_flag out_word;
%global fid;


%���������õ��Ǵ������ҿ��ǳ��ȴ�K_max�ݼ�
%��Ϊ����������ǣ�1.��ǰ�����г��ȴ�����Ѻ����� ���϶��ж��������2.��ǰ�����г���С���������ֻ��һ������
s2={32};
for i=1:size(base_son,2)
    if size(base_son,2)>9%�̼�����ȴ���8
        for k=k_max:-1:k_min
            for g=1:size(txt(1:size(anssor,1)),1)
                if strcmp(base_son(k_min:k),char(txt(g,:)))==1%˵�����ڻ��������һ�����滹��
                    if k+1<=size(base_son,2)&&strcmp(base_son(k+1),'G')==1%˵�����ڻ��������һ�����滹��
                        current_word=char(anssor(g,1));
                        disp([current_word]);
                        fid = fopen('E:\A��ʿС����\����ƪС����\ģ��ʵ��\last_endecode\GCduo_Gin_base1.txt','a');
                        fprintf(fid,'%s ',current_word);
                        fclose(fid);
                        out_word=strcat(out_word,s2,current_word);
                        base_son=base_son(k+2:size(base_son,2));
                        Decode_fun(base_son,txt,anssor,k_max);
                        words_son=out_word;
                        return
                    end
                end
                if k==size(base_son,2)&&strcmp(base_son(k_min:k),char(txt(g,:)))==1%����Ѱ�ҵ����һ����
                    current_word=char(anssor(g,1));
                    disp([current_word]);
                    fid = fopen('E:\A��ʿС����\����ƪС����\ģ��ʵ��\last_endecode\GCduo_Gin_base1.txt','a');
                    fprintf(fid,'%s ',current_word);
                    fclose(fid);
                    out_word=strcat(out_word,s2,current_word);
                    words_son=out_word;
                    decode_num=1;
                    return
                end
            end
        end
    else%�̼������С��8
        k_min_min=1;
        for k=size(base_son,2):-1:k_min_min
            for g=1:size(txt(1:size(anssor,1)),1)
                if strcmp(base_son(k_min_min:k),char(txt(g,:)))==1%˵�����ڻ��������һ�����滹��
                    if k+1<=size(base_son,2)&&strcmp(base_son(k+1),'G')==1
                        current_word=char(anssor(g,1));
                        disp([current_word]);
                        fid = fopen('E:\A��ʿС����\����ƪС����\ģ��ʵ��\last_endecode\GCduo_Gin_base1.txt','a');
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
                if k==size(base_son,2)&&strcmp(base_son(k_min_min:k),char(txt(g,:)))==1%����Ѱ�ҵ����һ����
                    current_word=char(anssor(g,1));
                    disp([current_word]);
                    fid = fopen('E:\A��ʿС����\����ƪС����\ģ��ʵ��\last_endecode\GCduo_Gin_base1.txt','a');
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