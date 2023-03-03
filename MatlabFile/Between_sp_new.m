function [ sp_num,sp ] = Between_sp_new( difcoding_num,difcoding)
%´®²¢×ª»»

sp_num=difcoding_num;
sp=zeros(2,sp_num);
sp(2,1)=1;

for i=1:sp_num
    if mod(i,2)==1
        sp(1,i)=difcoding(i);
        if i+1<=sp_num
            sp(1,i+1)=sp(1,i);
        end
    else
        sp(2,i)=difcoding(i);
        if i+1<=sp_num
            sp(2,i+1)=sp(2,i);
        end
    end 
end
    

