sets
   m  load   /m1*m3/
   t  time   /t1*t24/;

alias(t,tt) ;
   
Variables
    dirtaP1(m,t)      actual peak power
    dirtaP2(m,t)      actual peak power
    dirtaP3(m,t)      actual peak power
    obj1              objective function
    P1(m,t)           actual load curve
    P2(m,t)           actual load curve
    P3(m,t)           actual load curve
    S1(m,t)           EV charge
    c1(m,t)           price fixing
    c2(m,t)           price fixing
    c3(m,t)           price fixing
    R1(m,t)           loads' participate willingness
    R2(m,t)           loads' participate willingness
    R3(m,t)           loads' participate willingness
    f(m,t)            peak-shaving cost
    ;
    
binary Variables
     x1(m,t)        
     x2(m,t)
     x3(m,t)
     y(m,t);
     
Parameters
     yata         /0.9/
     Nmax         /8/
     Call         /680000/
     cTOU(t)       time-of-use price  /t1 7300,t2 7300,t3 7300,t4 7300,t5 7300,t6 9700,t7 9700,t8 9700,t9 12200,t10 12200,t11 12200,t12 12200,
                                       t13 9700,t14 9700,t15 12200,t16 12200,t17 12200,t18 12200,t19 9700,t20 9700,t21 7300,t22 7300,t23 7300,t24 7300/
     Pbase(t)      peak regulation capacity
     /t1 0.1,t2 0.1,t3 0.1,t4 3,t5 4,t6 2,t7 1,t8 0.1,t9 0.1,t10 0.1,t11 0.1,t12 3,
      t13 5,t14 1,t15 0.1,t16 0.1,t17 1,t18 2,t19 5,t20 2,t21 1,t22 0.1,t23 0.1,t24 0.1/;
      
SCALARS
                M1   Relaxed complementary M1             /10000000/
                M2   Relaxed complementary M2             /10000000/
                M3   Relaxed complementary M3             /10000000/;

table   P1base(m,t)     prediction load curve
     t1    t2    t3    t4    t5    t6    t7    t8    t9    t10   t11   t12   t13   t14   t15   t16   t17   t18   t19   t20   t21   t22   t23   t24
m1   0.9   1.4   1.7   2     2     0.9   0.8   0.7   0.6   0.4   0     0     0     0.7   1.8   2     1.7   1.1   0.6   0.4   0.3   0     0     0
m2   0.8   1.3   1.8   1.9   2.1   1.1   0.7   0.7   0.5   0     0     0     0.55  0.85  1.3   1.55  1.25  1.0   1     1     0.6   0     0     0
m3   0.2   1.7   1.3   1.9   1.4   1.2   0.6   1.0   0.4   0.3   0     0     0     0.72  1.53  1.34  1.4   1.2   1.0   1.7   1.11  0     0     0    
;
table   P2base(m,t)     prediction load curve
     t1   t2   t3   t4   t5   t6   t7   t8   t9   t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
m1   0    0    0    0    0    0    0    0    0    0    0    2.6  2.8  2.1  2.5  3.4  4.6  4.3  5.5  4.1  3.4  2.1  2.6  0 
m2   0    0    0    0    0    0    0    0    0    0    0    2.4  2.6  2.3  2.4  3.2  3.7  3.8  5.4  4.8  4.0  3.0  2.1  0.3
m3   0    0    0    0    0    0    0    0    0    0    0    1.8  1.9  1.6  2.7  3.4  5.0  4.5  5.6  3.9  3.8  3.6  2.2  0
;
table   P3base(m,t)     prediction load curve
     t1   t2   t3   t4   t5   t6   t7   t8   t9   t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
m1   2.5  2.4  2.1  2.1  2.1  2.0  1.4  1.0  0.4  0.1  0.5  1.2  1.2  0.6  0.6  0.6  0.5  0.5  1.8  2    2.8  3.3  3.7  3
m2   2.1  2.3  1.6  1.7  1.8  1.7  0.8  0.7  0.2  0.3  0.6  1.3  1.5  0.9  0.7  0.4  1.1  1.2  1.7  2.1  2.7  3.7  4.4  4.9  
m3   2.6  2.4  1.8  2.0  2.2  1.9  1.7  1.1  0.6  0.3  0.5  1.3  1.6  1.1  1.2  0.9  0.8  1.1  1.9  1.5  1.93 3.57 4    2
; 
table   P1max(m,t)     max actual load curve
     t1   t2   t3   t4   t5   t6   t7   t8   t9   t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
m1   0.5  0.5  0.5  1.5  1.5  0.5  0.5  0.5  0.5  0.5  0.2  1    1    1    0.2  0.5  0.5  1.5  1.5  1.5  0.5  0.3  0.3  0.3
m2   0.5  0.5  0.5  1.5  1.5  0.5  0.5  0.5  0.5  0.5  0.2  1    1    1    0.2  0.5  0.5  1.5  1.5  1.5  0.5  0.3  0.3  0.3
m3   0.5  0.5  0.5  1.5  1.5  0.5  0.5  0.5  0.5  0.5  0.2  1    1    1    0.2  0.5  0.5  1.5  1.5  1.5  0.5  0.3  0.3  0.3
;
table   P2max(m,t)     max actual load curve
     t1   t2   t3   t4   t5   t6   t7   t8   t9   t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
m1   0    0    0    0    0    0    0    0    0    0    0    1.5  1.5  1.5  1.5  2    2.5  2    3    2.5  2    1    1    0
m2   0    0    0    0    0    0    0    0    0    0    0    1.5  1.5  1.5  1.5  2    2.5  2    3    2.5  2    1    1    0
m3   0    0    0    0    0    0    0    0    0    0    0    1.5  1.5  1.5  1.5  2    2.5  2    3    2.5  2    1    1    0
;
table   P3max(m,t)     max actual load curve
     t1   t2   t3   t4   t5   t6   t7   t8   t9   t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
m1   1.5  1.4  1    1    1    1    0.5  0.3  0.1  0    0.2  0.5  0.5  0.1  0.1  0.1  0.1  0.1  0.5  1    1.5  1.5  1.5  1.5
m2   1.5  1.4  1    1    1    1    0.5  0.3  0.1  0    0.2  0.5  0.5  0.1  0.1  0.1  0.1  0.1  0.5  1    1.5  1.5  1.5  1.5
m3   1.5  1.4  1    1    1    1    0.5  0.3  0.1  0    0.2  0.5  0.5  0.1  0.1  0.1  0.1  0.1  0.5  1    1.5  1.5  1.5  1.5
;
table   S1min(m,t)     min charge capacity
     t1   t2   t3   t4   t5   t6   t7   t8   t9   t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
m1   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0 
m2   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0 
m3   0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0 
;
table   S1max(m,t)     max charge capacity
     t1   t2   t3   t4   t5   t6   t7   t8   t9   t10  t11  t12  t13  t14  t15  t16  t17  t18  t19  t20  t21  t22  t23  t24
m1   3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3 
m2   3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3 
m3   3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3    3
;

Equations
*************objective***********************   
    objective  minimization objective function
    eq1(m,t),eq2(m,t),eq3(m,t),eq4(m,t),eq5(m,t),eq6(m,t),      
*************scheduling constraints***********************
    eq7,eq14,eq15(m,t),eq16(m,t),eq17,eq18,
*************Cost persuasion***********************
    eq19,eq20,eq21,eq22,eq23,eq24,eq25,eq26,eq27,eq28,eq29,eq30,eq31,eq32,eq33,eq34,eq35,eq36,eq37,eq38,eq39;
*************************************************************************************************************************************   
***********objective*******************
Objective..                  obj1=e=sum(t,Pbase(t)-sum(m,dirtaP1(m,t))-sum(m,dirtaP2(m,t))-sum(m,dirtaP3(m,t)));
eq1(m,t)..                   dirtaP1(m,t)=l=P1max(m,t)*x1(m,t);    
eq2(m,t)..                   dirtaP2(m,t)=l=P2max(m,t)*x2(m,t);
eq3(m,t)..                   dirtaP3(m,t)=l=P3max(m,t)*x3(m,t);    
eq4(m,t)..                   dirtaP1(m,t)=e=P1(m,t)-P1base(m,t);    
eq5(m,t)..                   dirtaP2(m,t)=e=P2(m,t)-P2base(m,t);
eq6(m,t)..                   dirtaP3(m,t)=e=P3(m,t)-P3base(m,t);
***********scheduling constraints*******************
eq7(m,t)$(ord(t)<17 or ord(t)>23)..       y(m,t)=e=0;

eq14(m,t)..                  S1(m,t+1)=e=S1(m,t)+P2(m,t)/yata;
eq15(m,t)..                  p1(m,t)=g=-y(m,t)*P1base(m,t);
eq16(m,t)..                  p1(m,t)=l=y(m,t)*P1base(m,t);
eq17(m,t)..                  S1(m,'t24')=g=0.6*S1(m,t);
eq18(m,t)..                  S1(m,'t24')=l=5*S1(m,t);
eq19(m,t)..                  S1(m,t)=g=S1min(m,t);
eq20(m,t)..                  S1(m,t)=l=S1max(m,t);
eq21(m)..                    sum(t,x2(m,t))=l=Nmax;
eq22(m,t)..                  sum(tt$((ord(tt) ge ord(t)) and (ord(tt) le (ord(t)+5))),1-x2(m,tt))=g=1;
eq23(m,t)..                  sum(tt$((ord(tt) ge ord(t)) and (ord(tt) le (ord(t)+2))),x2(m,tt))=g=1*(x2(m,t)-x2(m,t-1));
eq24..                       sum((t,m),dirtaP3(m,t))=e=0;
eq25(m,t)..                  sum(tt$((ord(tt) ge (ord(t) eq 13)) and (ord(tt) le ((ord(t) eq 13)+2))),x3(m,tt))=g=3*(x3(m,t)-x3(m,t-1));
*************Cost persuasion***********************
eq26(m,t)..                  c1(m,t)=e=Call*dirtaP1(m,t)/(24*Pbase(t));
eq27(m,t)..                  c2(m,t)=e=Call*dirtaP2(m,t)/(24*Pbase(t));
eq28(m,t)..                  c3(m,t)=e=Call*dirtaP3(m,t)/(24*Pbase(t));
eq29(m,t)..                  f(m,t)=e=c1(m,t)*dirtaP1(m,t)+c2(m,t)*dirtaP2(m,t)+c3(m,t)*abs(dirtaP3(m,t));
eq30..                       sum((m,t),f(m,t))=l=1.1*Call;
eq31(m,t)..                  R1(m,t)=e=cTOU(t)*dirtaP1(m,t)+c1(m,t)*dirtaP1(m,t);
eq32(m,t)..                  R2(m,t)=e=-cTOU(t)*dirtaP2(m,t)-c2(m,t)*dirtaP2(m,t);
eq33(m,t)..                  R3(m,t)=e=cTOU(t)*dirtaP3(m,t)+c3(m,t)*abs(dirtaP3(m,t));
eq34(m,t)..                  R1(m,t)=g=-M1*(1-x1(m,t));
eq35(m,t)..                  R1(m,t)=l=M1*x1(m,t);
eq36(m,t)..                  R2(m,t)=g=-M2*(1-x2(m,t));
eq37(m,t)..                  R2(m,t)=l=M2*x2(m,t);
eq38(m,t)..                  R3(m,t)=g=-M3*(1-x3(m,t));
eq39(m,t)..                  R3(m,t)=l=M3*x3(m,t);

model CSEE /all/;
solve CSEE using minlp min obj1;
