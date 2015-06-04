# Copyright 2014-2015 Secken, Inc. All Rights Reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
# 
# NOTICE: All information contained herein is, and remains
# the property of Secken, Inc. and its suppliers, if any.
# The intellectual and technical concepts contained
# herein are proprietary to Secken, Inc. and its suppliers
# and may be covered by China and Foreign Patents,
# patents in process, and are protected by trade secret or copyright law.
# Dissemination of this information or reproduction of this material
# is strictly forbidden unless prior written permission is obtained
# from Secken, Inc..
# 
# 注意：此处包含的所有信息，均属于Secken, Inc.及其供应商的私有财产。
# 此处包含的所有知识、专利均属于Secken, Inc.及其供应商，属于商业秘密，
# 并受到中国和其他国家的法律保护。这些信息及本声明，除非事先得到
# Secken, Inc.的书面授权，否则严禁复制或传播。
# 
# 
# @author     Sean (seanzhang@secken.com)
# @version    0.5
# @project    pam

all: pam_secken.c
	gcc -fPIC -c cJSON.c pam_secken.c
	gcc -shared -o pam_secken.so cJSON.o pam_secken.o  -lm -lcurl -lpam -lssl

.PHONY: install clean


init: cJSON.h init.c
	gcc -o get_uid cJSON.c init.c -lcurl -lm

install: pam_secken.so
	install -D pam_secken.so /lib64/security/pam_secken.so
	rm -f pam_secken.so

clean:
	rm -f *.o *.so get_uid pam_secken.so
