#! /bin/bash

git clone https://github.com/nyseion/ardb.git
cd ardb
storage_engine=rocksdb make 
