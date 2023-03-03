function [interleaverCode] = interleaver(data)
    % 块交织 交织公式是  (((n-1)*17)%90)+1
    len = length(data);
    interleaverCode = zeros(1, len);

    for i = 1:len
        position = mod((i - 1) * 17, 90) + 1;
        interleaverCode(position) = data(i);
    end

end
