/*
* Copyright 2014-2015 Secken, Inc. All Rights Reserved.
* DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
*
* NOTICE: All information contained herein is, and remains
* the property of Secken, Inc. and its suppliers, if any.
* The intellectual and technical concepts contained
* herein are proprietary to Secken, Inc. and its suppliers
* and may be covered by China and Foreign Patents,
* patents in process, and are protected by trade secret or copyright law.
* Dissemination of this information or reproduction of this material
* is strictly forbidden unless prior written permission is obtained
* from Secken, Inc..
*
* 注意：此处包含的所有信息，均属于Secken, Inc.及其供应商的私有财产。
* 此处包含的所有知识、专利均属于Secken, Inc.及其供应商，属于商业秘密，
* 并受到中国和其他国家的法律保护。这些信息及本声明，除非事先得到
* Secken, Inc.的书面授权，否则严禁复制或传播。
*
*
* @author      Sean (seanzhang@secken.com)
* @version     0.5
* @project     pam
*/


#include <stdio.h>
#include <syslog.h>
#include <stdbool.h>

#define PAM_SM_ACCT

#include <security/pam_modules.h>
#include <security/_pam_macros.h>
#include <security/pam_modutil.h>
#include <security/pam_ext.h>


#include "utils.ic"


// secken login authentication function
// this function will pass appid and
// corresponding uid to api server
// after the server reckoned the couple
// it will prompt a notification on user's
// phone. this will return TRUE if user
// chose to click the OK button
bool
sk_login(pam_handle_t *pamh, const char *appid, const char *appkey, const char *uid) {
    int ret;
    // this function will blocked
    // until time out or user's
    // approval
    pam_syslog(pamh, LOG_NOTICE, "start to click\n");
    ret = click(appid, appkey, uid);
    if (ret == 0) {
        return true;
    }
    pam_syslog(pamh, LOG_NOTICE, "fail to pass due to %d\n", ret);
    return false;
}


PAM_EXTERN int
pam_sm_authenticate(pam_handle_t *pamh, int flags, int argc, const char **argv) {
    // appid, appkey, uid
    if (argc != 3) {
        return PAM_CRED_INSUFFICIENT;
    }
    if (sk_login(pamh, argv[0], argv[1], argv[2]) == true) {
        return PAM_SUCCESS;
    } else {
        return PAM_AUTH_ERR;
    }
}


PAM_EXTERN int
pam_sm_setcred(pam_handle_t *pamh, int flags, int argc, const char **argv) {
    return PAM_SUCCESS;
}
