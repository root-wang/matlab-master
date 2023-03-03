function [ doutI ,doutQ ] = gardner_sync( dinI , dinQ ,N)

I_Npara = reshape(dinI,N,length(dinI)/N);
Q_Npara = reshape(dinQ,N,length(dinQ)/N);

doutI = [];
doutQ = [];

for ii = 1000:1000:length(I_Npara)
    err = zeros(4,999);
    for jj = 1:N
        mid = mod(jj+N/2,N);
        if mid == 0
            mid = N;
        end
        if jj <= N/2
            err(jj,:) = abs(I_Npara(mid,ii-999:ii-1).*(I_Npara(jj,ii-998:ii)-I_Npara(jj,ii-999:ii-1)))+...
                        abs(Q_Npara(mid,ii-999:ii-1).*(Q_Npara(jj,ii-998:ii)-Q_Npara(jj,ii-999:ii-1)));
        else
            err(jj,:) = abs(I_Npara(mid,ii-998:ii).*(I_Npara(jj,ii-998:ii)-I_Npara(jj,ii-999:ii-1)))+...
                        abs(Q_Npara(mid,ii-998:ii).*(Q_Npara(jj,ii-998:ii)-Q_Npara(jj,ii-999:ii-1)));
        end
    end
    err_mean = sum(err.');
    index((ii)/1000) = find(err_mean == min(err_mean));
    doutI = [doutI I_Npara(index((ii)/1000),ii-999:ii)];
    doutQ = [doutQ Q_Npara(index((ii)/1000),ii-999:ii)];
end
end