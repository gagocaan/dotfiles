#!/usr/bin/env bash

set -e

os=$(uname -a | awk '{printf "%s %s", $4, $7}')
rootUsed=$(df -h $(PWD) | tail -n1 | awk '{printf "%s",$3}')
rootTotal=$(df -h $(PWD) | tail -n1 | awk '{printf "%s",$2}')
memUsed=$(top -l 1 -s 0 | grep PhysMem | awk '{printf "%s", $2}')
memTotal=$(top -l 1 -s 0 | grep PhysMem | awk '{printf "%s", $6}')
loadAvg=$(top -l 1 -s 0 | grep Load | awk '{printf "%s %s %s", $3, $4, $5}')

printf "
          _____                    _____          
         /\    \                  /\    \         
        /::\    \                /::\    \        
       /::::\    \              /::::\    \       
      /::::::\    \            /::::::\    \      
     /:::/\:::\    \          /:::/\:::\    \     
    /:::/  \:::\    \        /:::/  \:::\    \    
   /:::/    \:::\    \      /:::/    \:::\    \   
  /:::/    / \:::\    \    /:::/    / \:::\    \  
 /:::/    /   \:::\    \  /:::/    /   \:::\ ___\ 
/:::/____/     \:::\____\/:::/____/  ___\:::|    |
\:::\    \      \::/    /\:::\    \ /\  /:::|____|
 \:::\    \      \/____/  \:::\    /::\ \::/    / 
  \:::\    \               \:::\   \:::\ \/____/  
   \:::\    \               \:::\   \:::\____\    
    \:::\    \               \:::\  /:::/    /    
     \:::\    \               \:::\/:::/    /     
      \:::\    \               \::::::/    /      
       \:::\____\               \::::/    /       
        \::/    /                \::/____/        
         \/____/                                  
                                                  
Carlos Garzon                  $rootUsed/$rootTotal
Cloud Sofware Developer        $memUsed/$memTotal
https://github.com/gagocaan   辰$loadAvg
" | lolcat -t --seed=30 --spread=200
