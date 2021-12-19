%Classification using perceptron
clc
clear all
%Reading apple images
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

%Reading pears images
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

%Calculate for each image, colour and roundness
%For Apples
%1st apple image(A1)
hsv_value_A1=spalva_color(A1); %color
metric_A1=apvalumas_roundness(A1); %roundness
%2nd apple image(A2)
hsv_value_A2=spalva_color(A2); %color
metric_A2=apvalumas_roundness(A2); %roundness
%3rd apple image(A3)
hsv_value_A3=spalva_color(A3); %color
metric_A3=apvalumas_roundness(A3); %roundness
%4th apple image(A4)
hsv_value_A4=spalva_color(A4); %color
metric_A4=apvalumas_roundness(A4); %roundness
%5th apple image(A5)hsv_value_A5=spalva_color(A5); %color
hsv_value_A5=spalva_color(A5);
metric_A5=apvalumas_roundness(A5); %roundness
%6th apple image(A6)
hsv_value_A6=spalva_color(A6); %color
metric_A6=apvalumas_roundness(A6); %roundness
%7th apple image(A7)
hsv_value_A7=spalva_color(A7); %color
metric_A7=apvalumas_roundness(A7); %roundness
%8th apple image(A8)
hsv_value_A8=spalva_color(A8); %color
metric_A8=apvalumas_roundness(A8); %roundness
%9th apple image(A9)
hsv_value_A9=spalva_color(A9); %color
metric_A9=apvalumas_roundness(A9); %roundness

%For Pears
%1st pear image(P1)
hsv_value_P1=spalva_color(P1); %color
metric_P1=apvalumas_roundness(P1); %roundness
%2nd pear image(P2)
hsv_value_P2=spalva_color(P2); %color
metric_P2=apvalumas_roundness(P2); %roundness
%3rd pear image(P3)
hsv_value_P3=spalva_color(P3); %color
metric_P3=apvalumas_roundness(P3); %roundness
%2nd pear image(P4)
hsv_value_P4=spalva_color(P4); %color
metric_P4=apvalumas_roundness(P4); %roundness

%selecting features(color, roundness, 3 apples and 2 pears)
%A1,A2,A3,P1,P2
%building matrix 2x5
x1=[hsv_value_A3 hsv_value_A5 hsv_value_A7 hsv_value_P3 hsv_value_P4];
x2=[metric_A3 metric_A5 metric_A7 metric_P3 metric_P4];

pears=[hsv_value_P3 hsv_value_P4; metric_P3 metric_P4];
apples=[hsv_value_A3 hsv_value_A5 hsv_value_A7; metric_A3 metric_A5 metric_A7];
% estimated features are stored in matrix P:
P=[x1;x2];

%Desired output vector
T=[1;1;1;-1;-1];

plot(pears(1,:), pears(2,:), 'ro', apples(1,:), apples(2,:), 'go')

%% train single perceptron with two inputs and one output

w1 = randn(1);
w2 = randn(1);
b = randn(1);

n = 0.1;
error = 1;
iterations = 0;

disp("Pradedamas apmokymas, pradiniai rezultatai: b = "+b+", w1 = "+w1+", w2 = "+w2);

% Apmokymas
while error ~= 0

    for i = 1:5
        v = x1(i)*w1+x2(i)*w2+b;
        fprintf("pries: w1: %f, w2: %f, b: %f\n", w1, w2, b)
        if v > 0
	        y = 1;
        else
	        y = -1;
        end

        e = T(i) - y;

        w1 = w1 + n*e*x1(i);
        w2 = w2 + n*e*x2(i);
        b = b+n*e;
        
        fprintf("po: e: %f, w1: %f, w2: %f, b: %f\n", e, w1, w2, b)
        E(i) = e;
    end
    fprintf("iteracija baigta\n")
    error = 0;
    for i = 1:5
        if E(i) ~= 0
            error = 1;
        end
    end
    
    iterations = iterations + 1;

end

disp("Apmokymas baigtas, gauti rezultatai: b = "+b+", w1 = "+w1+", w2 = "+w2+", iteracijų: "+iterations);

% Testavimas
x1_test=[hsv_value_A1 hsv_value_A2 hsv_value_P2];
x2_test=[metric_A1 metric_A2 metric_P2];

disp("Pradedamas testavimas, naudojami "+length(x1_test)+" testavimo rinkiniai");

T_test=[1;1;-1];

for i = 1:length(x1_test)
    v = x1_test(i)*w1+x2_test(i)*w2+b;

    if v > 0
        y = 1;
    else
        y = -1;
    end

    e = T_test(i) - y;

    if e~=0, disp("Klaida ties "+i+" testavimo rinkiniu"); end

end

disp("Testavimas baigtas");