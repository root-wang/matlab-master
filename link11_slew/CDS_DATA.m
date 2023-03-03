function [CDSData] = CDS_DATA()
    % 循环编码 生成多项式
    poly = [1 0 1 0 1 0 0 1 1 1 0 0 1];
    dataNum = 48;

    baseData = randi([0 1], 1, dataNum);
    % 循环冗余校验编码
    data_CRCEncode = CRC_encode(baseData, poly);
    % 卷积编码多项式系数矩阵
    output1Poly = [1, 1, 0, 0, 1, 1, 1];
    output2Poly = [1, 0, 1, 1, 1, 0, 1];
    % 打孔咬尾卷积编码
    data_FTBCBEncode = FTBCB(data_CRCEncode, [output1Poly, output2Poly], '2/3');

    % 块交织
    data_interleaver = interleaver(data_FTBCBEncode);

    % 格雷编码
    data_grayEncode = gray_encode(data_interleaver);

    % 2进制 -> 8进制符号映射
    data_symbol = data_symbol_generate(data_grayEncode);

    % 添加训练序列
    data_add_train = [data_symbol, training_sequence()];

    % 加扰
    data_scrambler = scrambler(data_add_train);

    CDSData = data_scrambler;

end
