function new_cell =Random_cell(base_cell,array)%输入一个cell和需要交换位置的数组，对于数组中在cell里相同长度的随机交换位置
a=0;
for i=1:size(base_cell,1)
    if size(char(base_cell(i)),2)>a
        a=size(char(base_cell(i)),2);
        if i==1
            a_list=i;
        else
            a_list=[a_list i];
        end
    end
end
a_list=[a_list size(base_cell,1)];
leng=size(a_list,2);
for j=1:leng-2
    K=setdiff(find(array>a_list(leng-j)),find(array>a_list(leng-j+1)));%setdiff取并集

    K_list=array(K);
    K_list=unique(K_list);
    if isempty(K_list)==0
        %ranlindex=randperm(size(K,2));
        ranlindex=randsample(a_list(leng-j):(a_list(leng-j+1)),size(K_list,2));%y=randsample(50:100,10)生成50-100不相同的10个随机数

        %K_r=K_list(ranlindex);
%         if isempty(intersect(ranlindex,K_list))%inersect 取交集
%            K_r=ranlindex;
%         else
%            ranlindex=randsample(a_list(leng-j):(a_list(leng-j+1)),size(K_list,2));
%            K_r=ranlindex;
%         end
        while ~isempty(intersect(ranlindex,K_list)) %有交集就是1  说明有重复的  需要重新随机
            ranlindex=randsample(a_list(leng-j):(a_list(leng-j+1)),size(K_list,2));
        end
        K_r=ranlindex;
        zhongjian_cell=base_cell;
        if size(K_list,2)==size(K_r,2)
            base_cell(K_list)=zhongjian_cell(K_r);
            base_cell(K_r)=zhongjian_cell(K_list);
        else
            disp('good');
        end
    end
new_cell=base_cell;
end