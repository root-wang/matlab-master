function [enCodeData] = FTBCB(data, outputPoly, R)
    % 打孔咬尾卷积码
    % data: 输入数据
    % outputPoly:输出1到输出n的多项式系数矩阵数组
    % R: 卷积编码方式 用于输出的数据的组合方式

    cycleTime = length(data);
    dataTail = data(end - 5:end);

    dataWithInitTail = [dataTail, data];

    output1Poly = outputPoly(1);
    output2Poly = outputPoly(2);
    % 输出
    output1 = [];
    output2 = [];
    enCodeData = [];

    for i = 1:cycleTime
        % 当前编码器中的比特
        tmpCode = dataWithInitTail(i:i +6);
        % 输出值1
        tmpouput1 = mod(sum(tmpCode .* output1Poly), 2);
        % 输出值2
        tmpouput2 = mod(sum(tmpCode .* output2Poly), 2);

        if R == '1/2'
            enCodeData = [enCodeData, tmpouput1, tmpouput2];
        end

        if R == '2/3'
            enCodeData = [enCodeData, tmpouput1, tmpouput2];

            if mod(i, 2) == 0
                enCodeData = enCodeData(1:end - 1);
            end

        end

    end
