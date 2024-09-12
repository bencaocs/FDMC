function np=DNAcode2(p)
[m,l]=size(p);
for i=1:m
    for j=1:l %The value of j is: the initial value is 1,in steps of 2 to the end of py
        switch p(i,j) 
            case 0
                np(i,j)= 'T';
            case 1
                np(i,j)= 'C';
            case 2
                np(i,j)= 'G';
            case 3
                np(i,j)= 'A';
        end
    end
end

