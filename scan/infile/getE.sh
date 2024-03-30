#\bin\sh
rm -f hc_sort_dat
rm -f new.dat
dir0=`pwd`
#rm *_dat
cd ../
dir=$(pwd)
all=`ls ${dir}`
for i in $all
do
  if [ $i != infile ]; then
    cd $i
    dir1=`pwd`
    all1=`ls $dir1`
    for j in $all1
    do
      cd $j
      if [ `grep -c "Total CPU time used" ./OUTCAR` == 1 ]; then
        ii=`awk '/free  energy   TOTEN/{a=$0}END{print a}' ./OUTCAR`
        jj=`echo ${ii##*=}`
        kk=`echo ${jj%%eV*}`
      else
        kk=1103
      fi
      printf " %s %10.8f\n" $j $kk >> $dir0/${i}_dat
      cd ../
    done
    sort -n -k 2 $dir0/${i}_dat >> $dir0/${i}_sort_dat
    rm $dir0/${i}_dat
    cd ../
  fi
done
cd  infile
sed -i 's/new_/ /g' hc_sort_dat   # 去掉前缀new_
sort -n hc_sort_dat>new.dat  #按照第一列从打到小排序
rm -f hc_sort_dat
