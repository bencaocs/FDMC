function flag = GC(DNA)
[px,py] = size(DNA);
temp=[];
index = 1;
count=0;
for i=1:py
  if DNA(1,i) == 'C' || DNA(1,i) == 'G'
           count = count + 1;
    end
end
%if   count==floor(py/2)||py==1%向下取整  GC少   约束为不满足GC少 即在序列中分隔符两边GC少
if   count==ceil(py/2)||py==1%向上取整GC多  约束为满足GC多 即在序列中分隔符两边GC多
    flag=1;
else
    flag=0;
end
if py==0
    flag=0;
end
end