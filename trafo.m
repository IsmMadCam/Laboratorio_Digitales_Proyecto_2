function trafo(R,C,L,V2,f,a,R2,Xl2,R1,Xl1,gc,bm)
%caso que el capacitor sea cero
if (C==0)
    Zl=R+(2*pi*f*L)*1i;
else
    Zl=R+(2*pi*f*L)*1i-(1/(2*pi*f*C))*1i;
end
%calculo de I2
I2=(V2/Zl);
%calculo de e2
e2=(I2*R2)+(I2*Xl2*1i)+(V2);
%calculo de e1
e1=a*e2;
%calculo de I2prima
I2prima=(I2/a);
%calculo de i1
i1=I2prima+(e1*bm*1i)+(e1*gc);
%calculo de v1
v1=e1+(i1*R1)+(i1*Xl1*1i);
%pasar los resultados a magnitud y fase
fprintf('Resutados corriente i1: \n magnitud: %f  fase: %f \n',(abs(i1)),radtodeg(angle(i1)));
disp('Valor en numeros complejos de i1: ');
disp(i1);
fprintf('Resutados voltaje v1: \n magnitud: %f  fase: %f \n',abs(v1),radtodeg(angle(v1)));
disp('Valor en numeros complejos de v1: ');
disp(v1);
end