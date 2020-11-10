% CRC Part c
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
        % generate a random generating function g(x) 
        Gx = randi([0 1], 1,L)
        % Transmitted Data
        % Generate Random Data 
        Ix = randi([0 1], 1,L)
        remainder = binary_rem(Ix,Gx)
        Ex_dec = bi2de(remainder) + bi2de(Ix);
        Ex = de2bi(Ex_dec)
        %% Error Vector 
        % Generate randome number of errors between 0 (No Error) and L
        Nb_Error= randi([0 length(Ex)],1,1)
        % deine Error vector of zeros
        Error=zeros(1,length(Ex));
        %generate unique random positions of the above errors 
        Error_position= randperm(length(Error),Nb_Error)
        % Error Vector (1's are Position of Errors)
        Error(Error_position)=1
        % Received Message 
        Rx=Ex;
        % Flip Bits (0 to 1 and 1 to 0) at Location of Errors
        Rx(Error_position) = ~Rx(Error_position)
        % Find Remainder
        Check=binary_rem(Rx,Gx);
        % Check for Errors
    if  Check==0 
           undetected_error=undetected_error+1;
    end % End if 
    end % End inner for 
    L=L+12; 
    yD(i)=100*(undetected_error/1000);
end % End for 
% Plot 
plot(xL,yD)
xlabel('Frame size');
ylabel('Undetectedable Errors Ptecentage');
            