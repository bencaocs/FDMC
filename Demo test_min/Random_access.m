clear;
data=importdata('DNAbase_PAP_base2.txt');%����ָ���DNA����
ATCG=data;
count=0;

ATCG(size(ATCG,1))=[];
ATCG=cell2mat(ATCG);
random_acc_prim='TTGCGACGCGTC';%����ط���Ҫע��ȡ������
rap_len=length(random_acc_prim);
for j=1:size(ATCG,1)
    ATCG_curn=ATCG(j,:);
    for i=1:length(ATCG(1,:))-rap_len
        d = EditDist(random_acc_prim,ATCG_curn(i:rap_len+i-1));
        if d<2
            disp(j);
            disp(['----over----',ATCG_curn(i:rap_len+i-1)]);
        end
        count=count+1;
    end
    %disp(j);
end