function [CDSData] = CDS_DATA()
    % ѭ������ ���ɶ���ʽ
    poly = [1 0 1 0 1 0 0 1 1 1 0 0 1];
    dataNum = 48;

    baseData = randi([0 1], 1, dataNum);
    % ѭ������У�����
    data_CRCEncode = CRC_encode(baseData, poly);
    % ����������ʽϵ������
    output1Poly = [1, 1, 0, 0, 1, 1, 1];
    output2Poly = [1, 0, 1, 1, 1, 0, 1];
    % ���ҧβ�������
    data_FTBCBEncode = FTBCB(data_CRCEncode, [output1Poly, output2Poly], '2/3');

    % �齻֯
    data_interleaver = interleaver(data_FTBCBEncode);

    % ���ױ���
    data_grayEncode = gray_encode(data_interleaver);

    % 2���� -> 8���Ʒ���ӳ��
    data_symbol = data_symbol_generate(data_grayEncode);

    % ���ѵ������
    data_add_train = [data_symbol, training_sequence()];

    % ����
    data_scrambler = scrambler(data_add_train);

    CDSData = data_scrambler;

end
