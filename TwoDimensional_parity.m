% Two Dimensional Parity Error Detection Part a & b 
clear all
% L=12 --> 3x4 matrix 
% Set the Number of Columns=4 and Rows=3
Col=4; 
% Counters
no_error=0;
odd_error=0;
even_error=0;
detected_error=0;
undetected_error=0;
% Flags
fdetected_error=false;
fundetected_error=false;
% For 1000 Random Cases
for i=1:1:1000
    fdetected_error=false;
    fundetected_error=false;
    % Randomely Generated 3x4 Bit Matrix to Transmit
    Tx= randi([0 1], 3,Col)
    % Computing the Row Parity Vector and Column Parity Vector By Taking Modulus of the Summation
    P_Cols = mod(sum(Tx),2); % If A is a matrix, then sum(A) returns a row vector containing the sum of each column.(returns row)
    P_Rows = mod(sum(Tx,2),2);% if A is a matrix, then sum(A,2) is a column vector containing the sum of each row. (returns column)
    %% Error Vector
    % Generate Random Number of Errors between 0 (No Error) and 12
    Nb_Error= randi([0 length(Tx)],1,1)
    % Define Error Matrix (3x4) of Zeros
    Error=zeros(3,Col);
    % Generate Unique Random Positions of the Above Errors 
    Error_position = randperm(3*Col,Nb_Error)% randperm(n,k) returns a row vector containing k unique integers selected randomly from 1 to n 
    % Error Vector (1's are Position of Errors)
    Error(Error_position)=1
    % Transmitted Data 
    Rx=zeros(3,Col);
    Rx=Tx;
    % Flip Bits (0 to 1 and 1 to 0) at the Location Errors 
    Rx(Error_position)= ~Rx(Error_position)
    % Use Modulus to Check Received Data
    Check_Cols = mod(sum(Rx),2); % If A is a matrix, then sum(A) returns a row vector containing the sum of each column.(returns row)
    Check_Rows = mod(sum(Rx,2),2);% if A is a matrix, then sum(A,2) is a column vector containing the sum of each row. (returns column)
    % Compare Parity Vectors with Computed Check Vectors 
    for j=1:1:length(Check_Cols)
        if Check_Cols(j)~= P_Cols(j)
            fdetected_error=true;
            break;
        end
    end % End for 

    for k=1:1:length(Check_Rows)
        if Check_Rows(k)~= P_Rows(k)
            fdetected_error=true;
            break;
        end
    end % End for 

    if Nb_Error==0 
       no_error=no_error+1;
    else 
        if mod(Nb_Error,2)~=0
             odd_error=odd_error+1;
        elseif mod(Nb_Error,2)==0
             even_error=even_error+1;
        end % End if
    end % End if

    if  fdetected_error==true
        detected_error=detected_error+1;
    else
         undetected_error=undetected_error+1;
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