# Mathematical Gnostics Analysis of Cp Data
# help prepgnplot
# help gnsvplot


clear
star = (" ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ");
disp(star)
disp('Data Analysis by Mathematical Gnostics Initiated.')
disp('| Select appropriate options from the Menu |')

# Gnostic Analysis margin analysis
para = dfchoice
disp(star)

disp("Keep ready the excel file of measured data.")
%Experiment_name=input("Enter the experiment name: ","s");

# Measure Cp Data loading
data_filename=input('Enter excel file name with extension: ','s');
pkg load io
data = xlsread(data_filename);
%data = data(isnan(data));

disp(data)
disp(star)
disp("Excel Measured data uploaded successfully.")

y_data_value_input=input('Does excel file contain relative or dependent variable data in first column? <y/N> : ','s');
if y_data_value_input == 'y';
    y_data_value = input('Enter the reference data column number : ');
    dependent_data=data(:,y_data_value);
    disp("Selected Reference data:") 
    disp(dependent_data)
    else
    y_data_value = [0];
end

# Main MG Data Loading and selection of data
disp(star)
first_column = input('Enter the number of first column of data set: ')
last_column = input('Enter the number of last column of data set: ')
disp(star)

data_set = data(:,first_column:last_column);
disp('Selected data for Mathematical Gnostics data analysis.')
disp(data_set)
disp(star)
disp(star)

size_data = size(data_set);
iterations = size_data(1,1);
size_f = size_data(1,1);

# MG marginal analysis
disp('Gnostics Computation Initiated...')

intv_result = [];
for iterations = 1: iterations;
    para.data=[data_set(iterations,:)];
    [res,intv,lc,uc,err] = zw_marginal_analysis_egdf(para);
    intv_result = [intv_result; intv.fin];
    disp(strcat("Data set of :",data_filename))
    disp(strcat('Iteration no :', int2str(iterations),'/',int2str(size_data(1,1))))
    status_w = (iterations / size_data(1,1)) * 100;
    disp(strcat("Overall Status :",int2str(status_w),"%"))
    disp(intv_result)

    # gnp file generation and pdf
    gnp = prepgnplot(res);
    gnsvplot(gnp, strcat("group-a-1s-1r-",int2str(dependent_data(iterations,:)),".text"));

end
disp(star)
disp(strcat('Gnostics Computation Completed Successfully for :',data_filename))
disp(star)

# Save results
excel_sheet_name = ("MG-MA");
result_margin_analysis=xlswrite(data_filename,intv_result,excel_sheet_name);
disp(star)

# MG Marginal Analysis data load
mg_ma_data = intv_result;
# Marginal Analysis Calculations 
disp('Computing Marginal Analysis...')   
# MG Marginal Analysis typical data interval
uerr_tol = mg_ma_data(:,4)-mg_ma_data(:,3);
lerr_tol = mg_ma_data(:,3)-mg_ma_data(:,2);
# MG Marginal Analysis tolerance interval
uerr_td = mg_ma_data(:,5)-mg_ma_data(:,3);
lerr_td = mg_ma_data(:,3)-mg_ma_data(:,1);

diff_interval = [uerr_td, uerr_tol, mg_ma_data(:,3), lerr_tol, lerr_td];
diff_interval_sheet_name = ("Diff Int");
diff_interval_save = xlswrite(data_filename,diff_interval,diff_interval_sheet_name);
disp(strcat("Gnostics Marginal Analysis data saved in_",diff_interval_sheet_name,"_and_",excel_sheet_name," _sheets in excel file_",data_filename))
disp(star)

#MG robust regression
mg_rr_q = input("Do you want to perform gnostics robust regression? <y/N>",'s');

if mg_rr_q == 'y';

    disp(strcat("Gnostics Robust Regression initiated for ","_",data_filename))
    disp(star)
    x=dependent_data;
    y=mg_ma_data(:,3);
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