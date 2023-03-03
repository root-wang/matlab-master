function [ data_out ] = symbol_decision_qpsk(Isam , Qsam)
%UNTITLED3 QPSKĞÅºÅÅĞ¾ö

data_out = zeros(1,2*length(Isam));

Ifinal = zeros(1,length(Isam));
Qfinal = zeros(1,length(Qsam));
threshold=0;
for  i=1:length(Isam)
   if Isam(i)>=threshold
       Ifinal(i)=1;
   else
       Ifinal(i)=-1;
   end
   if Qsam(i)>=threshold 
   else
       Qfinal(i)=-1;
   end
end

for i=1:length(Isam)
   if Ifinal(i)==1
       data_out(2*i-1)=1;
   else
       data_out(2*i-1)=0;
   end

   if  Qfinal(i)==1
       data_out(2*i)=1;
   else
       data_out(2*i)=0;
   end
end

end

