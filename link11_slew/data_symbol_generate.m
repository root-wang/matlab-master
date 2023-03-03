function [symbolMapping] = data_symbol_generate(inputData)
    % 将进行相位编码的数据 按照权值进行 *2 然后变为一个3bit的八进制符号
    len = length(inputData);
    symbolMapping = [];

    for i = 1:len / 2
        code = inputData(i * 2 - 1:i * 2);
        code = mat2str(code);

        switch code
            case '[0 0]'
                symbolMapping = [symbolMapping, 0]; % 0 ->0
            case '[0 1]'
                symbolMapping = [symbolMapping, 2]; % 1 -> 2
            case '[1 0]'
                symbolMapping = [symbolMapping, 4]; % 2 -> 4
            case '[1 1]'
                symbolMapping = [symbolMapping, 6]; % 3 -> 6
        end

    end

end
