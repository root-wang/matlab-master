function [output] = upSample(input)
    % �ϲ���
    zero = upsample(input, 4);
    psf = rcosdesign(0.35, 8, 4, 'sqrt');
    pulse = conv(zero, psf);
    output = pulse(17:end - 16);

end
