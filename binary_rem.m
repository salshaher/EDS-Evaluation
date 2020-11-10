function [rem] = binary_rem(data,gx)
    crcw = length(gx)-1;
    initVal = zeros(1,crcw);
    finalXOR = zeros(1,crcw);
    am = [data,zeros(1,crcw)];
    am(1:crcw) = xor(am(1:crcw),initVal);
    % CRC calculation
    reg = [0,am(1:crcw)];
    for i=crcw+1:length(am)
        reg = [reg(2:end),am(i)];
    if reg(1)==1
        reg = xor(reg, gx);
    end
    end
    mcrc = reg(2:end);
%     rem = mcrc;
    rem = xor(mcrc,finalXOR);
end

