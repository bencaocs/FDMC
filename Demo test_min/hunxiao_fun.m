function words_son =hunxiao_fun(base_list,lengt,flag)%函数功能，给与任意长度的ATGC序列,判断是否只有一种解码形式,lengt 最大长度
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