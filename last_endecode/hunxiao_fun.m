function words_son =hunxiao_fun(base_list,lengt,flag)%�������ܣ��������ⳤ�ȵ�ATGC����,�ж��Ƿ�ֻ��һ�ֽ�����ʽ,lengt ��󳤶�
a=findstr(base_list(1:size(base_list,2)-1),'G');
b=size(a,2);
K=find(base_list=='G');
aa=[];
ia=0;
if isempty(find(K>flag, 1))
    words_son=0;
else
    for j=1:b

        c=K(:,j);
        if size(base_list(:,1:c-1),2)<=9&&size(base_list(:,c+1:end),2)<=9
            if GC(base_list(:,1:c-1))+GC(base_list(:,c+1:end))==2
                ia=ia+1;
            end
        end
    end
    if ia>1&&size(base_list,2)<=lengt
        words_son=1;
    else
        words_son=0;
    end
end
end