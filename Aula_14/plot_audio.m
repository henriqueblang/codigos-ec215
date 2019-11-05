function [] = plot_audio(audio, name)
%PLOT_AUDIO Plota um audio
    figure()
    subplot(2, 1, 1)
    plot(audio(:, 1))
    subplot(2, 1, 2)
    plot(audio(:, 2))
    title(name)
end

