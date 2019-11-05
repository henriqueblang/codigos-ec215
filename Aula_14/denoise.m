function [X, s] = denoise(y, Fs, T)
%DENOISE Remove ruido de um sinal y, T = threshold
    win = hamming(120,'periodic');
    noverlap = 80;
    
    fftlen = 512;
    s = stft(y,Fs,'Window',win,'OverlapLength',noverlap,'FFTLength',fftlen);
    s = threshold(s, T);
    
    [X,T] = istft(s, Fs, 'Window', win, 'OverlapLength', noverlap, 'FFTLength', fftlen, 'Method', 'ola', 'ConjugateSymmetric', true);
end

