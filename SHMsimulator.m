%--------------------------------------------------------------------------
%SHMSIMULATOR Plots the energy of a simple harmonic oscillator using 4
%different numerical methods and an analytical solution.
%The user is given the opportunity to create a new set of SHO solutions 
%with these 5 methods, or can skip and use data from created either
%manually or from a previous session.
%The energies predicted from these 5 different methods are then calulated
%and plotted.
% -------------------------------------------------------------------------
% Joseph Kellett
% University of Manchester
% March 2014
% -------------------------------------------------------------------------

close all;
clear all;
format long;

%Greet the user and ask for initial conditions.
fprintf('Welcome to SHMsimulator.')
skip=input('Do you wish to find the energies for a previous oscillator?  y/n ');
if skip==n %User wants to create files for a new oscillator....
    fprintf('You will be asked to enter the values of the \n');
    fprintf('to the following differential equation describing a damped harmonic oscillator \n');
    fprintf('\n m*a+d*v+k*x=0 \n');
    fprintf('\n where m is the mass of the oscillator, k the spring constant, \n');
    fprintf('d the damping coefficient, a the acceleration, v the velocity and \n');
    fprintf('and x the diplacement.\n\n');
    m=input('Please enter the mass of the oscillator, m, in kilograms.  ');
    k=input('Please enter the value of the spring constant, k.   ');
    d=input('Please enter the damping coefficient of the system, d.  ');
    x_0=input('Please enter the initial diplacement of the oscillator in metres.  ');
    v_0=input('Please enter the initial velocity of the oscillator. ');
    T=input('How long would you like the oscillator to run in seconds?  ');
    h=input('What step size do you wish to run the simulator at?  ');

    fprintf('The program will now plot phase diagrams and energy plots for \n');
    fprintf('for the Euler, Improved Euler, Euler-Cromer and Verlet methods')
    
%--------------------------------------------------------------------------
%Calculating and plotting displacements and velocities
%--------------------------------------------------------------------------

    [ x, v ,t ] = Analytical(x_0,v_0,k,m,d,h,T);%Analytical solution
    [ eux, euv, eut ] = Euler(x_0,v_0,k,m,d,h,T); %Solution from Euler
    [ iex, iev, iet ] = ImprovedEuler(x_0,v_0,k,m,d,h,T); %Solution from IEuler
    [ vex, vev, vet ] = Verlet(x_0,v_0,k,m,d,h,T); %Solution from Verlet
    [ ecx, ecv, ect ] = EulerCromer(x_0,v_0,k,m,d,h,T); %Solution from E-Cromer

    figure; %Creates new figure to be displayed to user.
    subplot(3,2,1) %Splits figure into 3 by 2 subplots.
    plot(real(x),real(v)); %Plots phase diagram using real parts of analytical solution.
    title('Analytical Solution'); 
    xlabel('Displacement(x) /m'); ylabel('Velocity (v) /ms^{-1}');

    %For the numerical data...
    subplot(3,2,3)
    plot(eux,euv);
    title('Euler Method'); 
    xlabel('Displacement(x) /m'); ylabel('Velocity (v) /ms^{-1}');

    subplot(3,2,4)
    plot(iex,iev);
    title('Improved Euler Method'); 
    xlabel('Displacement(x) /m'); ylabel('Velocity (v) /ms^{-1}');

    subplot(3,2,5)
    plot(ecx,ecv);
    title('Euler-Cromer Method'); 
    xlabel('Displacement(x) /m'); ylabel('Velocity (v) /ms^{-1}');

    subplot(3,2,6)
    plot(vex,vev);
    title('Verlet Method'); 
    xlabel('Displacement(x) /m'); ylabel('Velocity (v) /ms^{-1}');

    fprintf('Saving data to files...'); %Inform user data being saved.
    
%--------------------------------------------------------------------------
%Writing files
%--------------------------------------------------------------------------

    %Writes a new csv file to export the analytical data to.
    file_IDa=fopen('Analytical.csv', 'w');
    if file_IDa==-1 %Checks that file created correctly
       error('Could not create file!');
    end

    fprintf(file_IDa,'Time,Displacment,Velocity\n');%Writes headers

    %Writes analytical data double precision format.
    for i=1:length(t);
        fprintf(file_IDa,'%f,%f,%f\n',t(i),x(i),v(i));
    end
    fclose(file_IDa);

    %For the rest of the data...
    file_IDe=fopen('Euler.csv', 'w');
    if file_IDe==-1
       error('Could not create file!');
    end
    fprintf(file_IDe,'Time,Displacment,Velocity\n');
    for i=1:length(eut);
        fprintf(file_IDe,'%f,%f,%f\n',eut(i),eux(i),euv(i));
    end
    fclose(file_IDe);

    file_IDi=fopen('ImprovedEuler.csv', 'w');
    if file_IDi==-1
       error('Could not create file!');
    end
    fprintf(file_IDi,'Time,Displacment,Velocity\n');
    for i=1:length(iet);
        fprintf(file_IDi,'%f,%f,%f\n',iet(i),iex(i),iev(i));
    end
    fclose(file_IDi);

    file_IDc=fopen('EulerCromer.csv', 'w');
    if file_IDc==-1
       error('Could not create file!');
    end
    fprintf(file_IDc,'Time,Displacment,Velocity\n');
    for i=1:length(ect);
        fprintf(file_IDc,'%f,%f,%f\n',ect(i),eux(i),ecv(i));
    end
    fclose(file_IDc);

    file_IDv=fopen('Verlet.csv', 'w');
    if file_IDv==-1
       error('Could not create file!');
    end
    fprintf(file_IDv,'Time,Displacment,Velocity\n');
    for i=1:length(vet);
        fprintf(file_IDv,'%f,%f,%f\n',vet(i),vex(i),vev(i));
    end
    fclose(file_IDv);
    fprintf('Save successful!\n');
    
      file_IDv=fopen('Verlet.csv', 'w');
    if file_IDv==-1
       error('Could not create file!');
    end
    fprintf(file_IDv,'Time,Displacment,Velocity\n');
    fprintf(file_IDv,'%f,%f,%f\n',m,k,c);
    fclose(file_IDv);
    fprintf('Save successful!\n');
    
%--------------------------------------------------------------------------
%Reading files
%--------------------------------------------------------------------------

elseif skip==y %if user wants to read data from previous session
    fprintf=('Reading data...\n');
    
    %Opens analytical file
    file_id=fopen('Analytical.csv');
    if file_id==-1 %Checks that file opened correctly
       error('Could not open file!');
    end
    %Reads file missing the header
    data=textscan(file_id,'%f %f %f','Delimiter', ',', 'HeaderLines', 1);
    fclose(file_id); %close file
    t=data{1}; x=data{2}; v=data{3}; %Splits up the data
    
    %Repeat for rest of the files...
    file_id=fopen('Euler.csv');
    if file_id==-1
       error('Could not open file!');
    end
    data=textscan(file_id,'%f %f %f','Delimiter', ',', 'HeaderLines', 1);
    fclose(file_id);
    eut=data{1}; eux=data{2}; euv=data{3};
    
    file_id=fopen('ImprovedEuler.csv');
    if file_id==-1
       error('Could not open file!');
    end
    data=textscan(file_id,'%f %f %f','Delimiter', ',', 'HeaderLines', 1);
    fclose(file_id);
    iet=data{1}; iex=data{2}; iev=data{3};
    
    file_id=fopen('EulerCromer.csv');
    if file_id==-1
       error('Could not open file!');
    end
    data=textscan(file_id,'%f %f %f','Delimiter', ',', 'HeaderLines', 1);
    fclose(file_id);
    ect=data{1}; ecx=data{2}; ecv=data{3};
    
    file_id=fopen('Verlet.csv');
    if file_id==-1
       error('Could not open file!');
    end
    data=textscan(file_id,'%f %f %f','Delimiter', ',', 'HeaderLines', 1);
    fclose(file_id);
    vet=data{1}; vex=data{2}; vev=data{3};
    
    file_id=fopen('Coefficients.csv');
    if file_id==-1
       error('Could not open file!');
    end
    data=textscan(file_id,'%f %f %f','Delimiter', ',', 'HeaderLines', 1);
    fclose(file_id);
    m=data{1}; k=data{2}; c=data{3};
    
end

%--------------------------------------------------------------------------
%Plotting energies
%--------------------------------------------------------------------------
figure; %New graph
hold on %Plot lines on the same graphs
plot(t,Energy(x, v, k, m),'k') %Plot analytical energy against time
plot(eut,Energy(eux, euv, k, m),'r-.')
plot(iet,Energy(iex, iev, k, m),'b:')
plot(vet,Energy(vex, vev, k, m),'g--')
plot(ect,Energy(ecx, ecv, k, m),'m')
%legend and axes labels:
legend('Analytical Energy','Euler method Energy','Improved Euler method Energy','Verlet method Energy','Euler-Cromer method Energy');
xlabel('Time /s');
ylabel('Energy /J');

fprintf('Thank you for using SHMsimulator. Any data saved can be found in the\n')
fprintf('same folder as this script\n Exiting...\n')