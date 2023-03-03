function [ difcoding] = Between_difcoding_new( data_num,data )
%²î·Ö±àÂë
difcoding=zeros(1,data_num+1);
difcoding(1)=1;
for n=1:data_num
    if difcoding(n)==data(n)
        difcoding(n+1)=1;
    else
        difcoding(n+1)=0;
    end
end
difcoding=difcoding(2:data_num+1);
end
