% Two Dimensional Parity Error Detection Part c
clear all
% L=12 -->3x4 matrix 
% L=24 -->3x8 matrix
% L=36 -->3x12 matrix
% L=48 -->3x16 matrix
% L=60 -->3x20 matrix
% Set the number of columns (number of rows is fixed=3 )
Col=4; 
count =0;
v=1;
% Define x-axis L vector for plotting 
for q=12:12:300
    xL(v)=q;
    v=v+1;
end % End for 
for i=1:1:25
    % Counter
    undetected_error=0;
    % Flags 
    fdetected_error=false;
    fundetected_error=false;
    P_Cols=0;
    P_Rows=0;
    Check_Cols=0;
    Check_Rows=0;
    for l=1:1:1000
        % Randomly Generated 3xCol Bit Matrix to Transmit
        Tx= randi([0 1], 3,Col)
        %%
        % Evaluating the Row Parity Vector and Column Parity Vector By Taking
        % Modulus of the Summation
        P_Cols = mod(sum(Tx),2); % If A is a matrix, then sum(A) returns a row vector containing the sum of each column.(returns row)
        P_Rows = mod(sum(Tx,2),2);% if A is a matrix, then sum(A,2) is a column vector containing the sum of each row. (returns column)
        %% Error Vector
        % Generate random number of errors (scalars) between 0 and 12   
        Nb_Error= randi([0 length(Tx)],1,1)
        % define Error Matrix (3x4) of zeros
        Error=zeros(3,Col);
        %generate unique random positions of the above errors 
        Error_position = randperm(3*Col,Nb_Error)% randperm(n,k) returns a row vector containing k unique integers selected randomly from 1 to n 
        % in the error vector of zeroes change the 0 to 1 at error positions
        Error(Error_position)=1
        % Copy the message and the parity bit into the received message Rx
        Rx=zeros(3,Col);
        Rx=Tx;
        % Flip bits (0 to 1 and 1 to 0) at the location of the errors. 
        Rx(Error_position) = ~Rx(Error_position)
        % Use modules to check received data
        Check_Cols = mod(sum(Rx),2); % If A is a matrix, then sum(A) returns a row vector containing the sum of each column.(returns row)
        Check_Rows = mod(sum(Rx,2),2);% if A is a matrix, then sum(A,2) is a column vector containing the sum of each row. (returns column)
        for j=1:1:length(Check_Cols)
            if Check_Cols(j)~=P_Cols(j)
                fdetected_error=true;
                break;
            end % End if 
        end % % End for

        for k=1:1:length(Check_Rows)
            if Check_Rows(k)~=P_Rows(k)
                fdetected_error=true;
                break;
            end % End if 
        end % End for 
        if  ~(fdetected_error) | Nb_Error==0
             undetected_error=undetected_error+1;
        end % End if 

    end % End inner for 
    Col=Col+12;
    yD(i)=100*( undetected_error / 1000);
end % End for
% Plot
plot(xL,yD)
xlabel('Frame Size');
ylabel('Undetectable Errors Percenatge');