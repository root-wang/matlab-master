function y=mseq(coef)
n=length(coef);
N=2^n-1;
register=[zeros(1,n-1),1];
newregister=zeros(1,n);
y=zeros(1,N);
for i=1:N
    newregister(1)=mod(sum(coef.*register),2);
    for j=2:n
        newregister(j)=register(j-1);
    end
    register=newregister;
    y(i)=register(n);
end
end

% function y=mseq(coef)  
% m=length(coef);%确定寄存器数目  
% N=2^m-1;%确定周期  
% %mback=0;%用于存放反馈值  
% y=zeros(1,N);%用于存放输出序列  
% registers=[1,1,1,0,1,1,0];%确定寄存器初始值  
% for i=1:N  
% y(i)=registers(m);  
% mback=mod(sum(coef.*registers),2);  
% registers=[mback registers(1:end-1)];  
% end  