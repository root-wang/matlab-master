clear all;
close all;

frame_bit_nums = 24;

baseData = randi([0, 1], 1, frame_bit_nums);

hanMingEncodeData = hanMingEncode(baseData);

link11_data = pi_4_DQPSK(hanMingEncodeData);


