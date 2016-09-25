
function T1MAT(Rl,Ll,Cl)

    R1=0.279;
    R2=0.0698;
    Xl1=1.064;
    Xl2=0.266;
    gc=0.000567;
    bm=-0.00187;
    V2=115;
    a=2;

    if (Cl==0)
        Zl=Rl+((120*pi*Ll)*i)
    elseif (Ll==0)
        Zl=Rl+((1/(120*pi*Cl))*i)
    elseif (Cl==0 && Ll==0)
        Zl=Rl
    end

    I2=V2/Zl;
    E2=I2*(R2+Xl2*i+Zl);
    E1=a*E2;
    Io=E1*(gc-bm*i);
    I2p=I2/a;
    Cor=I2p+Io;
    Vol=Cor*(R1+(Xl1*i))+E1;
    
    I1=sprintf('Magitud y Fase de I1 = %s , %s',num2str(abs(Cor)),num2str(radtodeg(angle(Cor))));
    disp(I1);
    V1=sprintf('Magitud y Fase de V1 = %s , %s',num2str(abs(Vol)),num2str(radtodeg(angle(Vol))));
    disp(V1);
    
%     disp('Magnitud de I1 =');
%     disp(abs(Cor));
%     disp('Fase de I1 =');
%     disp(radtodeg(angle(I1)));
%     disp('Magnitud de V1 =');
%     disp(abs(V1));
%     disp('Fase de V1 =');
%     disp(radtodeg(angle(V1)));