% Импортируйте данные из csv-файлов
spectra = importdata('spectra.csv')
starNames = importdata("star_names.csv")
lambdaStart = importdata("lambda_start.csv")
lambdaDelta = importdata("lambda_delta.csv")
% Определите константы
lambdaPr = 656.28; %нм
speedOfLight = 299792.458; %км/c
NObs = size(spectra, 1)
NStars = size(starNames, 1)
lambdaEnd = lambdaStart + (NObs - 1)*lambdaDelta
lambda = (lambdaStart : lambdaDelta : lambdaEnd)'
% Определите диапазон длин волн
j = 0
ymax = 0
lambdaTrue = 656.28
c = 299792.458
speed = zeros(NStars, 1)
sHalist = zeros(NStars, 1)
idxlist = zeros(NStars, 1)
movaway = zeros(NStars, 1)
movaway = num2cell(movaway)
% Рассчитайте скорости звезд относительно Земли
fg1 = figure
for i = 1:1:NStars
    s = spectra(:, i)
    [sHa, idx] = min(s)
    
    if ymax < max(s)
        ymax = max(s)
    end
    
    lambdaHa = lambda(idx)
    sHalist(i) = sHa
    idxlist(i) = idx
    z = (lambdaHa / lambdaTrue) - 1
    speedi = z*c
    speed(i) = speedi
    
    if speedi < 0
        plot(lambda, s, "--", 'LineWidth', 1)
    else
        plot(lambda, s, "-", 'LineWidth', 3)
        j = j + 1
        movaway(j) = starNames(i)
    end
% Постройте график
 grid on
    xlabel('Длина волны, нм')
    ylabel(['Интенсивность излучения, эрг/см^2/с/', char(197)])
    title('Спектры звезд')
    hold on
end
legend(starNames)
movaway = movaway(1 : j)
text((((lambdaStart + lambdaEnd)/2 + lambdaStart)/2 + lambdaStart)/2, ymax*1.05, 'Сорокин Александр, Б04-005')
set(fg1, 'visible', 'on')
hold off
% Сохраните график
saveas(fg1, 'spectraplot', 'png')