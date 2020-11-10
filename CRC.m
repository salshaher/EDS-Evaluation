% CRC Part a & b
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
    % Generate a random generating function g(x) 
    Gx = randi([0 1], 1,L)
    % Transmitted Data
    Ix = randi([0 1], 1,L)
    % Find the remainder
    remainder = binary_rem(Ix,Gx)
    % Find E(x) = I(x) + remainder
    Ex_dec =  bi2de(Ix) + bi2de(remainder);
    % Convert E(x) to Binary 
    Ex = de2bi(Ex_dec)
    % Generating a Random Number of Errors
    Nb_Error= randi([0 length(Ex)],1,1)
    % Define Error Vector of Zeros
    Error=zeros(1,length(Ex));
    % Generate Unique Random Positions of the Above Errors 
    Error_position= randperm(length(Error),Nb_Error)
    % Error Vector (1's are Position of Errors)
    Error(Error_position)=1
    % Received Message 
    Rx=Ex;
    % Flip Bits (0 to 1 and 1 to 0) at the Location of the Errors
    Rx(Error_position)= ~Rx(Error_position)
    % Check Received Message for Errors 
    Check=binary_rem(Rx,Gx);

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
    else
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
bar(x,'FaceColor','k','EdgeColor',[0 .9 .9], 'LineWidth',5)
xlabel('Error types') 
ylabel('Counts')
xticklabels({'noError','evenError', 'oddError', 'undetectedError','detectedError'})
