% Internet Checksum Error Detection Part c
% b0 and b1 and b2 length=X bits
L=12;
X=4;
% modulus 
arth_mod = 2.^X-1;
v=1;
% Define x-axis L vector for plotting 
for q=12:12:300
    xL(v)=q;
    v=v+1;
end % End for 
% Transmitted Data
% example b0 = [ 1 0 1 1 ] 
% Generate Random Bits
for j=1:1:25
    undetected_error=0;
    for l=1:1:1000 
        % Transmitted Data
        b0= randi([0 1], 1,X)
        b1= randi([0 1], 1,X)
        % Computing b2
        sum_decimal=bi2de(b0)+bi2de(b1);
        modulus=mod(sum_decimal,arth_mod);
        sum_binary=de2bi(modulus,X,'right-msb')
        for i= 1:1:length(sum_binary)
            % 1's complement
            sum_binary(i)=~sum_binary(i);
        end
        ones_complement=sum_binary
        b2_decimal= mod(bi2de(ones_complement,2),arth_mod);
        b2=de2bi(b2_decimal,X,'right-msb')
        concat=[b0,b1];
        % Data to be Transmitted 
        Tx=[concat,b2]
        %% Error Vector
        % Generate random number of errors between 0 and 12
        Nb_Error= randi([0 length(Tx)],1,1)
        % define Error vector of zeros
        Error=zeros(1,length(Tx));
        %generate unique random positions of the above errors 
        Error_position= randperm(length(Error),Nb_Error)
        % in the error vector of zeroes change the 0 to 1 at error positions
        Error(Error_position)=1
        % Received Message 
        Rx=Tx;
        % Flip Bits (0 to 1 and 1 to 0) at Error Location 
        Rx(Error_position)= ~Rx(Error_position)
        Y=X;
        a = Rx(1:Y)
        b = Rx(Y+1:Y+Y)
        c = Rx(Y+Y+1:L)
        summation = bi2de(a,2)+bi2de(b,2)+bi2de(c,2);
        Check = mod(summation,arth_mod)
        if  Check==0
               undetected_error=undetected_error+1;
        end % End if 
    end % End inner for 
    X=X+4;
    L=L+12;
    yD(j)=100*(undetected_error / 1000);
end % End for 
% Plot 
plot(xL,yD)
xlabel('Frame Size');
ylabel('Undetectable Errors Percenatge');
