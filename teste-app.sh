#/bin/bash
RESULT="`wget -qO- http://localhost:8090`"
wget -q localhost:8090 
if [$? -eq 0]
then 
          echo 'ok - servico no ar!'
elif [[$RESULT == *"Number"*]]
then
          echo 'ok - numero de visitantes'
          echo $RESULT
else
          echo 'not ok - numero de visitantes'
          exit 1