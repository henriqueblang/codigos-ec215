clear;
clc;

[y, Fs] = audioread('jojo.wav');

% Colocando ruido no audio
nivel_ruido = 0.005;   % 0.005 eh um bom numero
yn = y + randn(size(y))*nivel_ruido;
% sound(yn, Fs)

% clear sound

% Comparando os graficos do audio original e o com ruido
plot_audio(y, 'audio original')
plot_audio(yn, 'audio com ruido')

% Mostrando o % spectrograma dos dois audios
figure()
subplot(2, 2, 1)
% spectrogram(y(:, 1))
title('% spectrograma original, canal esquerdo')
subplot(2, 2, 3)
% spectrogram(y(:, 2))
title('% spectrograma original, canal direito')

subplot(2, 2, 2)
% spectrogram(yn(:, 1))
title('% spectrograma com ruido, canal esquerdo')
subplot(2, 2, 4)
% spectrogram(yn(:, 2))
title('% spectrograma com ruido, canal direito')

% Removendo ruido com threshold = 0 (nao muda nada)
t = 0;
dy_left = denoise(yn(:, 1), Fs, t);
dy_right = denoise(yn(:, 2), Fs, t);

dy = [dy_left dy_right];
plot_audio(dy, 'audio com ruido apos stft, threshold = 0')

% Removendo ruido com threshold = 0.05 (melhor que eu consegui)
t = 0.05;
dy2_left = denoise(yn(:, 1), Fs, t);
dy2_right = denoise(yn(:, 2), Fs, t);

dy2 = [dy2_left dy2_right];
plot_audio(dy2, 'audio com ruido apos stft, threshold = 0.05')

% Removendo ruido com threshold = 0.08 (melhor que eu consegui)
t = 0.08;
dy3_left = denoise(yn(:, 1), Fs, t);
dy3_right = denoise(yn(:, 2), Fs, t);

dy3 = [dy3_left dy3_right];
plot_audio(dy3, 'audio com ruido apos stft, threshold = 0.08')

% Removendo ruido com threshold = 1 (abafa um pouco a flauta, ruido some por completo)
t = 1;
dy4_left = denoise(yn(:, 1), Fs, t);
dy4_right = denoise(yn(:, 2), Fs, t);

dy4 = [dy4_left dy4_right];
plot_audio(dy4, 'audio com ruido apos stft, threshold = 1')

% Removendo ruido com threshold = 1000 (mata o sinal inteiro)
t = 1000;
dy5_left = denoise(yn(:, 1), Fs, t);
dy5_right = denoise(yn(:, 2), Fs, t);

dy5 = [dy5_left dy5_right];
plot_audio(dy5, 'audio com ruido apos stft, threshold = 1000')
