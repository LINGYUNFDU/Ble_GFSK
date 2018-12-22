function x = gfsk_modulation(upSampRate,bits,h,B,T,t)
if nargin<=2
    B = 0.5;
    T = 1;
    h = 0.5;
end
numBits = length(bits);
%preamble = pkt_preamble(address);
upSampledBits = zeros(1,length(bits)*upSampRate);
upSampledBits(1:upSampRate:upSampRate*(numBits-1)+1) = bits*2-1;

p_s = pulse_shape(t,B,T);
% p_s = pulse_shape(t,0.5/8,8);
a = 2*pi*h*conv(upSampledBits,p_s);
% figure;plot(p_s,'r');
theta = cumsum(a/upSampRate);%phase 
% figure;plot(theta,'r');
x = exp(1j*theta);
end

