ts_gen=[];
for i=1:10
    header_word=randi([0 1],1,35);
    message_word=randi([0 1],1,210);
    data_in=[message_word,header_word(4:18)];
    [~,data_crc]=crc(data_in);
    baseband_encrypt=band_addnoise(data_crc);
    data_rs=rs([header_word baseband_encrypt]);
    interleaver=interleaving(data_rs);
    ccsk_encoder=ccsk(interleaver);
    data_trans_encrypt=trans_encrypt(ccsk_encoder);
    ts_gen=[ts_gen,add_syn_tr(data_trans_encrypt)];%ts_gen为 -1，1 序列
end

% fs=5e9;
% fc=969e6;
fs=5e8;
fc=2000;
fb=5e6;
Tbnumber=ceil(fs/fb);
%data_msk_out=msk_mod(ts_gen,fb,fc,fs);%(109+16+4)*32=4128bit

% fh_index=1;
data_msk_i=[];
data_msk_q=[];
for i=1:length(ts_gen)/32
    data_msk_in=(ts_gen(1+(i-1)*32:32*i)+1)/2;%将ts_gen由1，-1序列变为0，1序列，很重要！！！
    [data_msk_out_i,data_msk_out_q]=msk_mod(data_msk_in,fb,fc,fs);
%     [data_fh_out]=fh(fh_index,data_msk_out);
%     data_msk=[data_msk,data_fh_out,zeros(1,Tbnumber*33),data_fh_out,zeros(1,Tbnumber*33)];
    data_msk_i=[data_msk_i data_msk_out_i];
    data_msk_q=[data_msk_q data_msk_out_q];
end

data_msk_i_n=zeros(size(data_msk_i),'like',data_msk_i);
data_msk_1_n=zeros(size(data_msk_q),'like',data_msk_q);
snr = [0:18];
for i=1:length(data_msk_i)/1024
   data_msk_i_n((i-1)*1024+1:i*1024)=awgn(data_msk_i((i-1)*1024+1:i*1024),snr(randi([1,19])),'measured');
   data_msk_1_n((i-1)*1024+1:i*1024)=awgn(data_msk_q((i-1)*1024+1:i*1024),snr(randi([1,19])),'measured');
end


fidI = fopen('Link16_I.txt', 'w');
fidQ = fopen('Link16_Q.txt', 'w');
% len = length(Imod);
len = 4096000;
for i = 1:len
    fprintf(fidI, '%s\r\n', data_msk_i(i));
    fprintf(fidQ, '%s\r\n', data_msk_q(i));
end
fclose(fidI);
fclose(fidQ);





ratio=zeros(1,8);
for snr=0:7%计算ts_gen和data_demsk误码率
    
%加扰
data_msk1=awgn(data_msk,snr,'measured');%需要加measured，自行百度

data_demsk=[];
for i=1:length(data_msk1)/32/100
    data_demsk_in=[zeros(1,Tbnumber) data_msk1(1+(i-1)*32*Tbnumber:32*i*Tbnumber)];
    data_demsk_out=msk_demodu(fs,fc,data_demsk_in,Tbnumber);
    data_demsk_out=data_demsk_out(2:end);
    data_demsk=[data_demsk data_demsk_out];
end

[~,ratio(snr+1)]=biterr((ts_gen+1)/2,(data_demsk+1)/2);
end
snr=0:7;
plot(snr,ratio,'r-*')
xlabel('SNR(dB)'),ylabel('误码率')
grid on

data_del_syn=del_syn_tr(data_demsk);
data_detrans_encrypt=trans_encrypt(data_del_syn);
ccsk_decoder=ccsk_decode(data_detrans_encrypt);
deinterleaver=deinterleaving(ccsk_decoder);
data_ders=rs_decode(deinterleaver);
baseband_decrypt=band_addnoise(data_ders(length(header_word)+1:end));
[~,data_decrc]=crc_decode(baseband_decrypt,header_word);
message_word_out=data_decrc(1:length(message_word));



% %绘图
% data_msk_part=data_msk(1:2*Tbnumber*(32+33));
% data_msk_part_t=1/fs:1/fs:2*Tbnumber*(32+33)/fs;
% p1 = plot(data_msk_part_t,data_msk_part);%,'k','Linewidth',1.4);
% % axis([1/fb,max(data_msk_part_t),-2,2]);
% % xlabel("t/s");
% grid on;