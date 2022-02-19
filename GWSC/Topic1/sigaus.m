function sigVec = sigaus(dataX,snr,qcCoefs)
% Generate a Sine-Gaussian signal
% S = X(X,SNR,C)
% Generate a Sine-Gaussian signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and C is the vector of
% three coefficients [a1, a2, a3, a4] that parametrize the phase of the signal:
% exp(-(t-a1).^2./(2*a2^2)).*sin(2*pi*a3.*t+a4)

%Hui Sun, February 2022
sigVec = snr.*exp(-(dataX-qcCoefs(1)).^2./(2*qcCoefs(2)^2)).*sin(2*pi*qcCoefs(3).*dataX+qcCoefs(4));
end