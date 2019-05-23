function [theta, axialRatio, degreeOfPolarization] = estimateParametersFromWavePacket(uWavePacket, vWavePacket, vWavePacketHilbertTransformed)
%UNTITLED2 Summary of this function goes here
%   Estimate gravity wave parameters from a wave packet using the Stokes
%   parameters method.
u = uWavePacket;
v = vWavePacket;
I = mean(u.^2) + mean(v.^2);
D = mean(u.^2) - mean(v.^2);
P = 2*(mean(u.*v));
Q = 2*mean(u.*vWavePacketHilbertTransformed);
degreeOfPolarization = sqrt((P^2 + Q^2 + D^2)) / I;
if Q < 0.05 || P < 0.05 || degreeOfPolarization < 0.5 || degreeOfPolarization > 1
%if degreeOfPolarization < 0.5 || degreeOfPolarization > 1
   theta = 0;
   axialRatio = 0;
   degreeOfPolarization = 0;
   return;
else
    theta = 0.5 * atan(P / D);
    axialRatio = cot(0.5*asin(Q/(degreeOfPolarization*I)));
end
end
