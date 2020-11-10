% Single Parity Error Detection Part a & b 
clear all
% Set the frame length
L=12;
% Counters 
no_error=0;
odd_error=0;
even_error=0;
detected_error=0;
undetected_error=0;
% For 1000 Random Cases
for i=1:1:1000
    % Transmitted Data
    % Generate Random Bits
    Tx= randi([0 1], 1,L)
    %%
    % Evaluating the Single Bit Parity Using the Modulus for the Transmitted Data
    p1 = mod(sum(Tx),2); % Sum of All Columns Modulus 2 ( XOR )
    % Generating the codeword ( Appending the parity bit to the original transmitted data
    Txp1 = [ Tx p1 ] 
    %% Error Vector
    % Generate Randome Number of Errors between 0 (No Error) and L
    Nb_Error= randi([0 length(Txp1)],1,1)
    % Define Error Vector of Zeros
    Error=zeros(1,length(Txp1));
    % Generate Unique Random Positions of the Above Errors 
    Error_position= randperm(length(Error),Nb_Error)
    % Error Vector (1's are Position of Errors)
    Error(Error_position)=1
    % Received Message Rx
    Rx=Txp1;
    % Flip Bits (0 to 1 and 1 to 0) at the Location of the Errors
    Rx(Error_position)= ~Rx(Error_position)
    % Use Modulus to Check Received Data
    Check = mod(sum(Rx),2);
    % Check Whether the Error is Detected or Not
    % If result of modulus 2  is 1 then error is detected 
    % If result of modulus 2  is 0 then error is not detected or it is not detectable

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
    elseif  Nb_Error~=0 & Check==1
         detected_error=detected_error+1;
    end % End if
end % End for 
% Display Counters 
display(detected_error);
display(undetected_error);
display(odd_error);
display(even_error);
display(no_error);
% Display Counters Percentage
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