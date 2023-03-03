function [output] = series_2_parallel(input)

    outputI = input(1:2:end - 1);
    outputQ = input(2:2:end);

    output = [outputI; outputQ];
end
