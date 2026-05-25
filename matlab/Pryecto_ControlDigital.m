clc
clear all

m=0.00152; %Masa de la Bola en kg
R=0.0366; %Radio de La bola en metros
d=0.02475;%Distancia de brazo de palanca al centro del servo
g=-9.81;%Gravedad
L=0.28;%Largo de la viga
J=6.207e-7;%Momento de Inercia de la Bola

FrecSens=40;%Frecuencia en Hz de lecturas del sensor
FrecNy=2*FrecSens;%Frecuencia del Sensor Multiplicado por 2 Siguiendo el Teorema de Nyquist
T=1/FrecNy;%Tiempo de muestreo

n=[0 -m*g*d];
d=[L*(m+(J/(R^2))) 0 0];
G=tf(n,d);%Función de Transferencia del sistema

[Nz0,Dz0]=c2dm(n,d,T,'tustin');
[z,p,k]=tf2zpk(Nz0,Dz0)

Gz=c2d(G,0.01,'tustin')%Funcion de Trasnferencia Discretizada

pzmap(Gz)

Gc = pidtune(Gz, 'PID');

% Ver los parámetros sintonizados
Gc
