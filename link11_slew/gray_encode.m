function [grayEncode] = gray_encode(data)

    len = length(data);
    grayEncode = [];

    for i = 1:len / 2
        code = data(i * 2 - 1:i * 2);
        code = mat2str(code);

        switch code
            case '[0 0]'
                grayEncode = [grayEncode, 0, 0];
            case '[0 1]'
                grayEncode = [grayEncode, 0, 1];
            case '[1 0]'
                grayEncode = [grayEncode, 1, 1];
            case '[1 1]'
                grayEncode = [grayEncode, 1, 0];
        end

    end

end
