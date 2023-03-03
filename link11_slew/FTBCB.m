function [enCodeData] = FTBCB(data, outputPoly, R)
    % ���ҧβ�����
    % data: ��������
    % outputPoly:���1�����n�Ķ���ʽϵ����������
    % R: ������뷽ʽ ������������ݵ���Ϸ�ʽ

    cycleTime = length(data);
    dataTail = data(end - 5:end);

    dataWithInitTail = [dataTail, data];

    output1Poly = outputPoly(1);
    output2Poly = outputPoly(2);
    % ���
    output1 = [];
    output2 = [];
    enCodeData = [];

    for i = 1:cycleTime
        % ��ǰ�������еı���
        tmpCode = dataWithInitTail(i:i +6);
        % ���ֵ1
        tmpouput1 = mod(sum(tmpCode .* output1Poly), 2);
        % ���ֵ2
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
