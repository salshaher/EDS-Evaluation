% Internet Checksum Error Detection Part a & b
% b0 and b1 and b2 length=4 bits
L=4;
% Find the modulus 
arth_mod = 2.^L-1;
% Counters
no_error=0;
odd_error=0;
even_error=0;
detected_error=0;
undetected_error=0;
% For 1000 Random Cases 
for i=1:1:1000
    % Generate Random L bits Tuple b0
    b0= randi([0 1], 1,L)
    % Transmitted Data
    % example b1 = [ 1 0 1 1 ]] 
    % Generate Random L bits Tuple b1
    b1= randi([0 1], 1,L)
    % Finding L bits Tuple b2
    sum_decimal=bi2de(b0)+bi2de(b1)
    modulus=mod(sum_decimal,arth_mod)
    sum_binary=de2bi(modulus,L,'right-msb')
    % Finding the complement 
    for i= 1:1:length(sum_binary)
        % 1's complement
        sum_binary(i)=~sum_binary(i);
    end % End for 
    ones_complement=sum_binary
    % Compute b2 in Decimal 
    b2_decimal= mod(bi2de(ones_complement,2),arth_mod)
    % Convert b2 to Binary
    b2=de2bi(b2_decimal,4,'right-msb')
    % Concat b0 , b1 and b2
    concat=[b0,b1];
    Tx=[concat,b2] % the data to be transmitted 
    %% Error Vector
    % Generate Random Number of Errors between 0 (No Error) and 12
    Nb_Error= randi([0 length(Tx)],1,1)
    % Define Error Vector of Zeros
    Error=zeros(1,length(Tx));
    % Generate Unique Random pPositions of the Above Errors 
    Error_position= randperm(length(Error),Nb_Error)
    % Error Vector (1's are Position of Errors)
    Error(Error_position)=1
    % Received Message 
    Rx=Tx;
    % Flip Bits (0 to 1 and 1 to 0) at the Location of the Errors
    Rx(Error_position)= ~Rx(Error_position)
    % Check Received Message for Errors 
    a=Rx(1:4)
    b=Rx(5:8)
    c=Rx(9:12)
    % ( a + b + c ) % arth_mod
    % Convert a , b and c to Decimal and Sum
    summation=bi2de(a,2)+bi2de(b,2)+bi2de(c,2)
    % Find the Remainder 
    Check=mod(summation,arth_mod)
    % Check for Errors 
    if Nb_Error==0 
       no_error=no_error+1;
    else 
        if mod(Nb_Error,2)~=0
             odd_error=odd_error+1;
        elseif mod(Nb_Error,2)==0
             even_error=even_error+1;
        end % End if
    end % End if

    if  Check==0
           undetected_error=undetected_error+1;
    elseif  Nb_Error~=0 & Check~=0
         detected_error=detected_error+1;
    end % End if
end % End for
% Display Counters 
display(detected_error);
display(undetected_error);
display(odd_error);
display(even_error);
display(no_error);
% Display Counters Percentages 
fprintf("ratio of detected error");
display(100*(detected_error / 1000));
fprintf("ratio of undetected error");
display(100*( undetected_error / 1000));
fprintf("ratio of odd error");
display(100*(odd_error / 1000));
fprintf("ratio of even error");
display(100*( even_error / 1000));
fprintf("ratio of no error");
display(100*(no_error / 1000));
% Plot
x=[no_error,even_error, odd_error, undetected_error,detected_error];
bar(x)
xlabel('Error types') 
ylabel('Counts') 
xticklabels({'noError','evenError', 'oddError', 'undetectedError','detectedError'})