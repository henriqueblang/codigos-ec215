function [ signal ] = threshold(signal, t)
%THRESHOLD Zera valores menores que t em signal
    signal(abs(signal) < t) = 0;
end
