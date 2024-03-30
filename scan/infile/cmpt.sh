#!/bin/sh
read -p "Are you ready to recompute (yes or No):  " lab
if [ $lab == yes  ]; then
  for i in hc ;     #没在当前路径
  do
    rm -r ../$i    #$i就是hc呗，还定义成一个变量，搞不懂。删除hc
    mkdir ../$i    #新建hc

    dir=`cd ./poscar/$i; pwd; cd ..` #打开当前目录下的poscar/hc/ 显示，然后返回poscar
    all=`ls ${dir}` #陈列poscar/hc 下的文件？
    for j in $all   # 获取poscar/hc下的文件名
    do
      echo ${i}_$j  #输出到哪了
      if [ $j != $i.sh ]; then   #这是设么条件？
        mkdir ../$i/$j
        cp ./input/INCAR  ../$i/$j #将input/INCAR 输入文件输出到上一路径的$i/$j径上
        cp ./input/KPOINTS  ../$i/$j #将input/KPOINTS 输入文件输出到上一路径的$i/$j径上
        cp ./input/POTCAR  ../$i/$j  #将input/POTCAR 输入文件输出到上一路径的$i/$j径上
        cp ./poscar/$i/$j ../$i/$j/POSCAR   #hc就是$i？使poscar/hc下文件变成文件夹,文件复制到文件夹的poscar中
    
        cd ../$i/$j  #进入自洽文件夹下
        cat > sub << EOF  #这个sub是临时文件？遇到EoF就结束 把脚本命令写入sub? 是的
#!/bin/sh
#BSUB -J  ${i}_$j
#BSUB -n  48
#BSUB -q  cpu-s
#BSUB -o %J.out
#BSUB -e %J.err
#BSUB -R "span[ptile=48]"
hostfile=\`echo \$LSB_DJOB_HOSTFILE\`
NP=\`cat \$hostfile | wc -l\`
mkdir  \$LSB_JOBID
source /public/software/intel/bin/compilervars.sh intel64
mpirun -np \$NP -machinefile \$LSB_DJOB_HOSTFILE  /public/software/bin/vasp_std
EOF
        bsub < sub  #退出自洽文件
        cd ../../infile
      fi
    done
  done
else
  echo "non_compute is runing"
fi

