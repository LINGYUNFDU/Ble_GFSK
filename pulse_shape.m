function [ y ] = pulse_shape(t,B,T)
% t=-2:1/upSampRate:2;
if nargin<2
    B = 0.5;
    T = 1;
end
% sigma = sqrt(log(2))/(2*pi*B*T);
%y=(sqrt(2)*sigma/2)/2.*((1/sqrt(pi).*exp(-(t+0.5.*T).^2/(2*sigma^2*T^2))-1/sqrt(pi).*exp(-(t-0.5.*T).^2/(2*sigma^2*T^2))+((t+0.5.*T)/(sqrt(2)*sigma*T)).*erfc((-t-0.5*T)/(sqrt(2)*sigma*T))-((t-0.5*T)/(sqrt(2)*sigma*T)).*erfc((-t+0.5*T)/(sqrt(2)*sigma*T))));
y = 1/(T)*(qfunc(2*pi*B*(t-T/2)/sqrt(log(2)))-qfunc(2*pi*B*(t+T/2)/sqrt(log(2))));
% plot(y);
end
