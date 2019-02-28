#!/bin/bash
find . -name  '*.md' | for x in `xargs -0` ; do sed -i 's#D:\\docs\\blogs\\images\\#http:\/\/www.it18zhang.com\/images\/blog\/xpc_#g' $x ; done
