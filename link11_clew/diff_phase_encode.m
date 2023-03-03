function [output] = diff_phase_encode(xk, yk)
    len = length(xk);
    syncode = importdata('capture_sync.txt');
    data_I = [transpose(syncode),xk];
    data_Q = [transpose(syncode), yk];

    a = [[1 0.707 0 -0.707 -1 -0.707 0 0.707]
        [0 0.707 1 0.707 0 -0.707 -1 -0.707]];
    j = 0;
    I_real = zeros(len, 1);
    Q_imag = zeros(len, 1);

    for i = 1:1:len

        if (data_I(i) == 0 && data_Q(i) == 0)
            j = j + 5;
        elseif (data_I(i) == 0 && data_Q(i) == 1)
            j = j + 3;
        elseif (data_I(i) == 1 && data_Q(i) == 0)
            j = j + 7;
        else
            j = j + 1;
        end

        j = mod(j, 8);
        I_real(i) = a(1, j + 1);
        Q_imag(i) = a(2, j + 1);
    end

    output = [data_I(2:end); data_Q(2:end)];

end
