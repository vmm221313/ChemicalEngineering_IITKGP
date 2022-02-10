1. On opening the MATLAB Code Script, click on Run to execute the code.
2. 4 plots are generated for component A in top product, component B in top product, component A in bottom product, component B in bottom product; each vs time.
3. The steady state seen to arrive at around the 1st time step.
4. The solution for all unknown variables exists in the x matrix.
5. The x matrix has 54 columns and the number of rows defined by the solver for the span of time.

The column order is as follows for following variables: -
Column 1: MR
Column 2 and 3: Xi, R where i = A,B
Column 4: M1,D
Column 5 and 6: Xi, D where i = A1, B1
Column 7 to 9: XA1, i where 1<=i<f
Column 10 to 12: XB1,i where 1<=i<f
Column 13 to 15: M1,i where 1<=i<f
Column 16 and 17: Xi,f where i = A1, B1
Column 18: M1,f
Column 19 to 29: XA1,i where f<i<=N
Column 30 to 40: XB1,i where f<i<=N
Column 41 to 51: M1,i where f<i<=N
Column 52: M1,B
Column 53 and 54: Xi,B where i = A1, B1

Thank You for reading !!