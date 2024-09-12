clear;
[A,txt,]=xlsread('test.xlsx');
%Enter the microsatellite, calculate the entropy, excel has two columns, the first is the base of the microsatellite, the second is the frequency of occurrence
entropy_txt=char(txt);
sum_A=sum(A);
X = ones(1,size(entropy_txt,2))*sum_A;
current_calu_base_single_sum=0;
for i=1:size(A)
    current_calu_base=entropy_txt(i,:);
    for j=1:size(entropy_txt,2)
        for k=1:size(A)
            if current_calu_base(j)==entropy_txt(k,j)
                current_calu_base_single_sum=current_calu_base_single_sum+A(k);
            end
        end
        current_calu_base_single_sum_l=current_calu_base_single_sum;
        current_calu_base_single_sum=0;
        if j==1
            calu_base_list=current_calu_base_single_sum_l;
        else
            calu_base_list=[calu_base_list current_calu_base_single_sum_l];
        end
    end
    entropy_sigle=-log2(calu_base_list/sum_A).*(calu_base_list/sum_A);
    entropy_sigle_sum=sum(entropy_sigle);
    if i==1
        entropy_sigle_sum_list=entropy_sigle_sum;
    else
        entropy_sigle_sum_list=[entropy_sigle_sum entropy_sigle_sum_list];
    end
end
cumsum_entropy=cumsum(entropy_sigle_sum_list)*2;
plot(cumsum_entropy);
title('Encoded A/T/G/C-content')
xlabel('Article sequence number');
ylabel('A/T/G/C-concent');
axis tight
grid off
box on
legend('base-concent')
%csvwrite('entropy_list.csv',cumsum_entropy);