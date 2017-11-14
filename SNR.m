function snr = SNR(sig1,sig2)
%  SNR- Signal/Noise ratio
%  Usage
%    value=SNR(sig1,sig2)
%  Inputs   
%    sig1	Original reference signal
%    sig2	Restored or noisy signal
%  Outputs
%    value	Signal/Noise ratio.
%


snr=20*log10(norm(sig1)/norm(sig1-sig2));
