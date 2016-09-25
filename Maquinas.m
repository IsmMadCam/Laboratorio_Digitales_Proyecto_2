function Maquinas (zl)
r1 = 0.279;
r2= 0.0698;
xL1= 1.064i;
xL2= 0.266i;
gc = 0.567e-3;
bm= -1.87e-3i;
v2 =115;
i2= v2/zl;
e2= v2+i2*xL2+i2*r2;
e1= 2*e2;
igc= e1*gc;
ibm= e1*bm;
ifi=igc+ibm;
i1= ifi+ i2/2;
v1= i1*r1 + i1* xL1 + e1;
disp ('la magnitud de   v1 es: ');
disp(abs(v1));
angv1= angle(v1)*180/pi;
disp ('la fase de v1 es: ');
disp (angv1);
disp ('la magnitud v2 es: ');
disp(abs(v2));
angv2= angle(v2)*180/pi;
disp ('la fase de v2 es: ');
disp (angv2);
disp ('la magnitud de i1 es: ');
disp(abs(i1));
angi1= angle(i1)*180/pi;
disp ('la fase de i1 es: ');
disp (angi1);
disp ('la magnitud  de i2 es: ');
disp(abs(i2));
angi2= angle(i2)*180/pi;
disp ('la fase de i2 es: ');
disp (angi2);

end

