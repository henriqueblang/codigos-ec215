function [] = plot_spectro(audio)
%PLOT_SPECTRO Summary of this function goes here
    figure()
    subplot(2, 1, 1)
    spectrogram(audio(:, 1))
    subplot(2, 1, 2)
    spectrogram(audio(:, 2))
end
