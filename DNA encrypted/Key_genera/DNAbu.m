function H = DNAbu(IntDNAMatrix)
% Computes the complementary sequence of IntDNAMatrix and returns the integer value H
%set=['ATGCTTT'];   a=DNAbu(set);  OUTPUT:a=TACGAAA
quanwei3=ones(1,size(IntDNAMatrix,2))*3;
IntDNAMatrix1 = DNAnum2let(IntDNAMatrix);
IntDNAMatrix2 = quanwei3-str2num(IntDNAMatrix1')';%can add fliplr, a matrix flip, which is the inverse complement of the
H = DNAcode2(IntDNAMatrix2);
end