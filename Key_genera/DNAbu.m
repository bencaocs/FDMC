function H = DNAbu(IntDNAMatrix)
% ����IntDNAMatrix�Ļ������У���������ֵH
%set=['ATGCTTT'];   a=DNAbu(set);  OUTPUT:a=TACGAAA
quanwei3=ones(1,size(IntDNAMatrix,2))*3;
IntDNAMatrix1 = DNAnum2let(IntDNAMatrix);
IntDNAMatrix2 = quanwei3-str2num(IntDNAMatrix1')';%���Լ�fliplr������ת�������油
H = DNAcode2(IntDNAMatrix2);
end