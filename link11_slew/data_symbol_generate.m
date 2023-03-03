function [symbolMapping] = data_symbol_generate(inputData)
    % ��������λ��������� ����Ȩֵ���� *2 Ȼ���Ϊһ��3bit�İ˽��Ʒ���
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
