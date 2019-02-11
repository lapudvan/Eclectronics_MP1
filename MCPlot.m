hold on
M = csvread('MC_data.csv');
t = M(:, 1);
v = M(:, 2);

startValues = zeros(1, 100);
j = 1;
lastStart = -100;

for i = 1:length(t)
    if t(i) == 0 && i > lastStart + 20
        startValues(j) = i;
        j = j + 1;
        lastStart = i;
    end
end



for i = 1:length(startValues)-1
    time = t(startValues(i):(startValues(i+1)-1));
    volts = v(startValues(i):(startValues(i+1)-1));
    
    startWave = 0;
    index = 0;
    endWave = 0;
    direction = 0;
    
    for j = 2:length(time)
        if (volts(j) > 0.2) && (volts(j) < 3) && (volts(j) < volts(j-1)) && (startWave == 0)
            startWave = time(j);
            index = j;
            direction = -1;
        elseif volts(j) > 0.2 && volts(j) < 3 && volts(j) > volts(j-1) && startWave == 0
            startWave = time(j);
            index = j;
            direction = 1;
        elseif startWave > 0 && volts(j) > 0.2 && volts(j) < 3 && volts(j) < volts(j-1) && j > index + 100 && direction == -1 && endWave == 0
            endWave = time(j);
        elseif startWave > 0 && volts(j) > 0.2 && volts(j) < 3 && volts(j) > volts(j-1) && j > index + 100 && direction == 1 && endWave == 0
            endWave = time(j);
        end
    end
    period = endWave - startWave;
    if period < 0.85 || period > 1.15
        disp('NOOOOOOO');
        disp(period)
        disp(i);
%         disp(startWave);
%         disp(endWave);
    end
    plot(i, period, 'bo');
%     disp(period);
end