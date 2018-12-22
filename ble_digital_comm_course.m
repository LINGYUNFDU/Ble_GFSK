clear; close all;
% hold on
%%% coding decoding parameter
% mode:s = 2 or s = 8;
% SH:soft SH :1 or hard SH =:0;
% NcoH:noncoherent:0 or coherent:1
numBits = 400;
mode = 2; % 1 or 2 or 8
upSampRate = 2;% up sampling rate
t = -8:1/upSampRate:8;
B = 0.5; T = 1; h = 0.5;
snrDb1 = -4;
snrDb2 = 10;
snrDb = snrDb1:2:snrDb2;
numSnrPt = length(snrDb);

numchanLoop = 1;
for k = 1:numchanLoop
    payload = round(rand(1,numBits));
    if mode == 1
        packet = payload;
    elseif mode == 2
        packet = fec_enc(payload,mode);
    elseif mode == 8
        payload = fec_enc(payload,mode);
        packet = pattern_mapping(payload);
    end
    %  packet = pkt_gen(2,'ac',pld);
    
    %%% modul demodul parameter
    numBits = length(packet);
    s = gfsk_modulation(upSampRate,packet,h,B,T,t);%µ÷ÖÆ
    nt = zeros(1,100);
    s = [nt,s];
    sigLen = length(s);
    %%% noise
    BER = zeros(1,numSnrPt);
    for mm = 1:numSnrPt
        noise = (randn(1,sigLen)+1j*randn(1,sigLen))*db2mag(-snrDb(mm))/sqrt(2)*sqrt(upSampRate);
        rcvSig = s+noise;
        startPt = detector_synch();
        demodBits = gfsk_demod();
        data = fec_decode();
        BER(mm) = BER(mm)+sum(data~=payload)/numBits/numchanLoop;
    end
end
semilogy(snrDb,BER)