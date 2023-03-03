function [output] = scrambler(inputData)
    % 加扰
    % 160个周期扰码
    scramblerCode = [0, 2, 4, 3, 3, 6, 4, 5, 7, 6, 7, 0, 5, 5, 4, 3, 5, 4, 3, 7, 0, 7, 6, 2, 6, 2, 4, 6, 7, 2, 4, 7, 5, 5, 7, 0, 7, 3, 3, 3, 7, 3, 3, 1, 4, 2, 3, 7, 0, 2, 7, 7, 3, 5, 1, 0, 1, 4, 0, 5, 0, 0, 0, 0, 7, 5, 1, 4, 5, 4, 2, 0, 6, 1, 4, 7, 5, 0, 1, 0, 3, 0, 3, 1, 3, 5, 1, 2, 5, 0, 1, 7, 1, 4, 6, 0, 2, 3, 3, 4, 2, 5, 2, 5, 4, 5, 7, 3, 1, 0, 1, 6, 4, 1, 1, 2, 1, 4, 1, 5, 4, 2, 7, 4, 5, 1, 6, 4, 6, 3, 6, 4, 5, 0, 3, 6, 4, 0, 1, 6, 3, 3, 5, 7, 0, 5, 7, 7, 2, 5, 2, 7, 7, 4, 7, 5, 5, 0, 5, 6];

    len = length(inputData);
    rest_scramblerCode = mod(len, 160);
    repeat_nums = (len - rest_scramblerCode) / 160;
    scramblerCodePadding = [];

    for i = 1:repeat_nums
        scramblerCodePadding = [scramblerCodePadding, scramblerCode];
    end

    scramblerCodePadding = [scramblerCodePadding, scramblerCode(1:rest_scramblerCode)];

    output = mod((inputData + scramblerCodePadding), 8);

end
