clear;
clc;

START_TIME = 40;

RATIO = -0.1;
INTERVAL = 1;

TOTAL_INTERVAL = abs(INTERVAL / RATIO);

[y Fs] = audioread('Roundabout.wav');

timePatch = START_TIME;
for i = 1:TOTAL_INTERVAL   
    y((Fs * timePatch):(Fs * (timePatch + INTERVAL)), :) *= (1 + (i * RATIO));
    
    timePatch += INTERVAL;
end

alteredSample = y((Fs * START_TIME):(Fs * (START_TIME + TOTAL_INTERVAL)), :);

audiowrite('Roundabout_altered.wav', alteredSample, Fs);
sound(alteredSample(1:(Fs * 5), :) , Fs * 0.5);
sound(alteredSample((Fs * 5):end, :) , Fs * 1.5);