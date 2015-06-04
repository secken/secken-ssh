########################################################################
# Copyright 2014-2015 Secken, Inc.  All Rights Reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
#
# NOTICE:  All information contained herein is, and remains
# the property of Secken, Inc. and its suppliers, if any.
# The intellectual and technical concepts contained
# herein are proprietary to Secken, Inc. and its suppliers
# and may be covered by China and Foreign Patents,
# patents in process, and are protected by trade secret or copyright law.
# Dissemination of this information or reproduction of this material
# is strictly forbidden unless prior written permission is obtained
# from Secken, Inc..
#
# 注意：此处包含的所有信息，均属于Secken, Inc. 及其供应商的私有财产。
# 此处包含的所有知识、专利均属于Secken, Inc. 及其供应商，属于商业秘密，
# 并受到中国和其他国家的法律保护。这些信息及本声明，除非事先得到
# Secken, Inc. 的书面授权，否则严禁复制或传播。
#
#
# @author    Sean (seanzhang@secken.com)
# @version   0.5
# @project   pam
########################################################################


#!/bin/bash


cdis=`cat /etc/issue | head -c 6`

handle_centos () {
    if [ ! -f "/usr/include/curl/curl.h" ]; then
        zypper install  curl-devel
    fi
    if [ ! -f "/usr/include/security/pam_modules.h" ]; then
        zypper install pam-devel
    fi
}


handle_centos () {
    if [ ! -f "/usr/include/curl/curl.h" ]; then
        yum -y install curl-devel
    fi
    if [ ! -f "/usr/include/security/pam_modules.h" ]; then
        yum -y install pam-devel
    fi
}


handle_redhat () {
    if [ ! -f "/usr/include/curl/curl.h" ]; then
        yum -y install libcurl-devel
    fi
    if [ ! -f "/usr/include/security/pam_modules.h" ]; then
        yum -y install pam-devel
    fi
}


handle_ubuntu () {
    if [ ! -f "/usr/include/curl/curl.h" ]; then
        apt-get install libcurl4-openssl-dev
    fi
    if [ ! -f "" ]; then
        apt-get install libpam0g-dev
    fi
}


if [ "$cdis" = "CentOS" ];  then
    handle_centos
fi


if [ "$cdis" = "Ubuntu" ]; then
    handle_ubuntu
fi


# well, here is a simple and wild solution for
# system distribution provider detectation.
# the first 6 letters of Red Hat is "Red Ha"
if [ "$cdis" = "Red Ha" ]; then
    handle_redhat
fi


if ["$cdis" = "Welcom" ]; then
    handle_opensuse
fi
