% set=['AGAGCC'];
% a=DNAbu(set);
date_now=datevec(date)';
%datelist=[date_now(1) date_now(2) date_now(3)];
datelist=[2022,7,20];%假设时间种子是2022-7-20
datelist_2=dec2bin(datelist);

a1=datelist_2(1,:);
a=char(abs(datelist_2(1,:)-datelist_2(3,:))+'0');
b = char(bitxor(a1-'0',datelist_2(2,:)-'0')+'0');
c = char(bitxor(a1-'0',datelist_2(3,:)-'0')+'0');
datelist_all=[datelist_2;a;b;c];
% datelist_left=datelist_all;
% datelist_right=datelist_all;
for i=1:size(datelist_all,1)
    da=datelist_all(i,:);
    if i==1
        datelist_left=da(1:5);
        datelist_right=da(6:10);
        datelist_last=[datelist_left;datelist_right];
    end
    datelist_last=[datelist_last;da(1:5);da(6:10)];
end
datelist_last_10=bin2dec(datelist_last);
datelist_last_unique=unique(datelist_last_10);
[A,base_DNA,]=xlsread('计算熵.xlsx');
for j=1:size(datelist_last_unique,1)
    if j==1
        cell_txt=cell2mat(base_DNA(datelist_last_unique(j)+1));
    else
        if mod(j,2)==0
            cell_txt=[cell_txt DNAbu(base_DNA(datelist_last_unique(j)+1))];
        else
            cell_txt=[cell_txt cell2mat(base_DNA(datelist_last_unique(j)))];
        end
    end
end
