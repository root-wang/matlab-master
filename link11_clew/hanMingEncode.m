function [encodeData] = hanMingEncode(data)
    % (30,24) hanMingenCode

    encodeData = zeros(1, 6);
    encodeData = [data, encodeData];

    %∆Ê–£—È
    sum_group_1 = sum(encodeData(12:24));
    encodeData(end) = mod(sum_group_1, 2) ~= 1;
    sum_group_2 = sum([encodeData(5:11), encodeData(19:24)]);
    encodeData(end - 1) = mod(sum_group_2, 2) ~= 1;
    sum_group_3 = sum([encodeData(2:4), encodeData(8:11), encodeData(15:18), encodeData(23:24)]);
    encodeData(end - 2) = mod(sum_group_3, 2) ~= 1;
    sum_group_4 = sum([encodeData(1), encodeData(3), encodeData(4), encodeData(6), encodeData(7), encodeData(10), encodeData(11), encodeData(13), encodeData(14), encodeData(17), encodeData(18), encodeData(21), encodeData(22)]);
    encodeData(end - 3) = mod(sum_group_4, 2) ~= 1;
    sum_group_5 = sum([encodeData(1), encodeData(2), encodeData(4), encodeData(5), encodeData(7), encodeData(9), encodeData(11), encodeData(12), encodeData(14), encodeData(16), encodeData(18), encodeData(20), encodeData(22), encodeData(24)]);
    encodeData(end - 4) = mod(sum_group_5, 2) ~= 1;
    sum_group_6 = sum([encodeData(1:24), encodeData(26:30)]);
    encodeData(end - 5) = mod(sum_group_6, 2) ~= 1;

end
