% Single Parity Error Detection Part c
clear all
% Set the frame length
L=12;
v=1;
% Define x-axis L vector for plotting 
for q=12:12:300
    xL(v)=q;
    v=v+1;
end % End for 
for i=1:1:25
    undetected_error=0;
    for l=1:1:1000
        % Transmitted Data
        %Tx = [ 1 0 1 1 0 1 0 1 1 0 1 0] 
        % Generate Random Bits
        Tx= randi([0 1], 1,L)
        %%
        % Evaluating the Single Bit parity using the Modules for the transmitted
        % data
        p1 = mod(sum(Tx),2);
        % Generating the codeword ( Appending the parity bit to the original
        % transmitted data
        Txp1 = [ Tx p1 ] 
        %% Error Vector
        % Generate randome number of errors between 0 and L
        Nb_Error= randi([0 length(Txp1)],1,1)
        % deine Error vector of zeros
        Error=zeros(1,length(Txp1));
        %generate unique random positions of the above errors 
        Error_position= randperm(length(Error),Nb_Error)
        % in the error vector of zero change the 0 to 1 at the position of the
        % errors
        Error(Error_position)=1
        % Copy the message and the parity bit into the received message Rx
        Rx=Txp1;
        % Flip bits (0 to 1 and 1 to 0) at the location of the errors. 
        Rx(Error_position)= ~Rx(Error_position)
        % Use modules to check received data
        Check = mod(sum(Rx),2);
        % Check whether the error is detected or not
        if  Check==0 & Nb_Error~=0
               undetected_error=undetected_error+1;
        end % End if 
    end % End inner for 
    yD(i)=100*( undetected_error / 1000);
    % Increment Frame Size
    L=L+12;
end % End for
plot(xL,yD)
xlabel('Frame Size');
ylabel('Undetectable Errors Percenatge');
% P.S. plot not smooth because were incrementing the frame size by 12 and not 1 =)