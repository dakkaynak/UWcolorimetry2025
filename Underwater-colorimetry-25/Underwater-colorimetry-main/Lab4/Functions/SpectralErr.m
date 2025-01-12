function E = SpectralErr(GT,estimation,wavelength, channel)
E = 100*abs(GT - estimation)./GT;
aveE = mean(E);
maxE = max(E);

figure;
subplot(1,2,1)
plot(wavelength,GT,'--m', 'LineWidth', 2)
hold on;
plot(wavelength, estimation, 'c', 'LineWidth', 2)
xlabel('wavelength [nm]')
ylabel('[1/m]')
legend('Ground Truth', [channel])
title([channel], 'channel estimation')

subplot(1,2,2)
plot(wavelength,E,'--o', 'LineWidth', 2)
hold on;
plot(wavelength, aveE,'oc', 'LineWidth', 2)
title(sprintf('Average err: %f , Max err: %f', aveE, maxE));
xlabel('wavelength [nm]')
ylabel('[%]')
legend('Spectral Error', 'Average Error')

end