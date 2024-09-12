function new_sequence = err_fun(sequence,err_type,err_pro)
%ERR_FUN 此处显示有关此函数的摘要
%   此处显示详细说明
base_ATGC=['A','G','T','C'];
err_num=round(size(sequence,2)*err_pro);
y=randsample(15:size(sequence,2),err_num);
new_sequence=sequence;
if err_type==2%delete
    new_sequence(y)=[];
end

for i=1:size(y,2)
    if err_type==1%insert
        base_y=randsample(1:4,1);
        new_sequence = insertAfter(new_sequence,new_sequence(y(i)-14:y(i)),base_ATGC(base_y));
    end
    if err_type==3%替换
        base_y=randsample(1:4,1);
        new_sequence(y(i)) = base_ATGC(base_y);
    end
end
end

