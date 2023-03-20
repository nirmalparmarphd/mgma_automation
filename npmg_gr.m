# Mathematical Gnostics Analysis of Cp Data
clear
star = (" ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ");
disp(star)
disp('Data Analysis by Mathematical Gnostics Initiated.')


disp("Keep ready the excel file of measured data.")
%Experiment_name=input("Enter the experiment name: ","s");

# Measure Cp Data loading
data_filename=input('Enter excel file name with extension: ','s');
pkg load io
data = xlsread(data_filename);
%data = data(isnan(data));

#================================================================
molar_mass_sample = 419.36; # enter the molar mass of the sample 
#================================================================

disp(data)
disp(star)
disp("Excel Measured data uploaded successfully.")

 
y_data_value = 1;
#================================================================
dependent_data=(data(:,y_data_value) .+ 273); # converted in kelvin
#================================================================
disp("Selected Reference data:") 
    
# MG Marginal Analysis data load
mg_ma_data = data(:,2:6);

#MG robust regression
mg_rr_q = input("Do you want to perform gnostics robust regression? <y/N>",'s');

if mg_rr_q == 'y';

    disp(strcat("Gnostics Robust Regression initiated for ","_",data_filename))
    disp(star)
    x=dependent_data;
    y=(mg_ma_data(:,3).*molar_mass_sample);
    funcdeg = input("Enter the degree for Gnostics Robust Regression:_")
    int=1 ; Nmet=1 ; mpe=1;
    mg_rr_result = roblinregression(x, y, funcdeg, int, Nmet, mpe);
        
    mg_rr_result_data_name=strcat(int2str(data_filename),'-rr_result.txt');
    graphroblinreg(mg_rr_result,mg_rr_result_data_name)

    disp(strcat("GNUPLOT script for Gnostics Robust graph saved as_",int2str(data_filename),"-rr_result.txt"))
    disp(strcat("Gnostics Robust Regression Completed of_" ,data_filename))
    disp(star)
    disp(star)
    disp("Gnostics Data Analysis Completed Successfully!")
    disp(star)
    else mg_rr_q != 'y';
    disp('NOTE: Gnostics Robust Regression Quitted.')
    disp(star)
    disp(star)
    disp("Gnostics Data Analysis Completed Successfully!")
    disp(star)
end