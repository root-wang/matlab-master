function [EOMData] = EOM()
    %EOM - EOM信息字段 全0或者全1共90bit
    %
    % Syntax: output = EOM()
    dataNum = 90;
    baseData = ones([1, dataNum]);

    % 交织
    data_interleaver = interleaver(baseData);

    % 格雷编码
    data_grayEncode = gray_encode(data_interleaver);

    % 2进制 -> 8进制符号映射
    data_symbol = data_symbol_generate(data_grayEncode);

    % 添加训练序列
    data_add_train = [data_symbol, training_sequence()];

    % 加扰
    data_scrambler = scrambler(data_add_train);

    EOMData = data_scrambler;

end
