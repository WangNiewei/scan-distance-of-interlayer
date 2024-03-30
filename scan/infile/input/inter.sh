#!/bin/sh
rm -f ../poscar/hc/* #清空hc文件内容
###此文件用于的能量扫描2023/4/11zyjwnw
E=$(seq -3 0.2 3)
for delta in $E
#for delta in -1.0 -0.8 -0.4 -0.2 -0.1 -0.05 -0.04 -0.03 -0.02 -0.01 0.0 0.01 0.02 0.03 0.04 0.05 0.1 0.2 0.4 0.8 1.2 1.6 2.0     
do
#######################################################################
Cconstant=$(awk 'NR==5{printf ("%.4f\n", $3)}' POSCAR)       #a3z大下
DirectdeltaC=` echo "scale=7; $delta / $Cconstant" |bc -l`   #分数坐标下delta的值
#awk '{if(NR==10||NR==13||NR==14){$3=$3+"'$DirectdeltaC'"}}1' POSCAR > POSCAR_new  #10，13，14移动原子z的行号,这里不能保留小数位

awk '{
      if (NR==10||NR==13||NR==14)   
                  printf "%10.16f %10.16f %10.16f\n",$1,$2,$3+"'$DirectdeltaC'"

      else
      print $0
}' POSCAR >../poscar/hc/new_$delta
#######################################################################
done 
