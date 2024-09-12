function H = DNAbu(IntDNAMatrix)
% 计算IntDNAMatrix的互补序列，返回整数值H
%set=['ATGCTTT'];   a=DNAbu(set);  OUTPUT:a=TACGAAA
quanwei3=ones(1,size(IntDNAMatrix,2))*3;
IntDNAMatrix1 = DNAnum2let(IntDNAMatrix);
IntDNAMatrix2 = quanwei3-str2num(IntDNAMatrix1')';%可以加fliplr，矩阵翻转，就是逆补
H = DNAcode2(IntDNAMatrix2);
end