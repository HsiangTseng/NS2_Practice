#這是測量CBR封包遺失率的awk程式

BEGIN {
#程式初始化,設定一變數記錄packet被drop的數目
# fsDrops = 0;
 numSs = 0;
 numRs = 0;
  loss = 0;
}

{

action=$1;
time=$2;
from=$3;
to=$4;
type=$5;
pktsize=$6;
flow_id=$8;
src=$9;
dst=$10;
seq_no=$11;
packet_id=$12;

#統計從n1送出多少packets
 if (from==0 && to==1 && action == "+")
  numSs++;

#統計n19收到多少packets
  if (to==2 && action == "r")
     numRs++;
     
#計算兩點之間的packet差數
  loss = numSs - numRs;

#統計flow_id為2,且被drop的封包
# if (flow_id==0 && action == "d") 
#  fsDrops++;
}
END {
 printf("number of packets sent:%d reveive:%d lost:%d\n", numSs, numRs, loss);
}
