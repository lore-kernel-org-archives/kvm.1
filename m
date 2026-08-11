Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6963921D0
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473316; cv=none; b=BtxkptRdReZJIoMo9l+xEV0/CfieO4LRvM9drWO3g966gonFyknMiNyLgoCrhsE6aXO5yTKj0W6rbMosK8sU9awc9oyecbpBLO9zgiuMScdJ+BJda0ICxifyJHaqKgz0gUrx4l9OG3816FwFwPzJslJmTqh9Fqx1R3mZa2POHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473316; c=relaxed/simple;
	bh=rbhU3BLfxLJ0GV+kvxRPS9jOsLdzo+U9hBKH9Q0YfEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8hW5JbCdEhM/536HEa1bQbWrKhZH/MkmHRKAl5zOi8PtuL3Vy87iE1p8InAa0QMeEBreomO+iEHw5yhMyYfvYdc29cHdfxkawPK/6RCkjGflE4v76vpCWntgycIvwnX2izBLxTMkha9ZrT/6tmXUN1iOLdDTR85+WivsjgkTAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lql9sAjZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BjWtxYE7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lql9sAjZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BjWtxYE7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGNv4v858620
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5cKNYN1YVV/K1jHg9iJCW7yGQ3ybLzpVvQJS3M//mQs=; b=Lql9sAjZZP6bEaBy
	jmWk3rsV8wV7KJWNWxp3H4c+7+MVeD/Fn0H5xpOyk/HNHk7IDwxEST/2ah/xrW+8
	kdyPnyB5DfKyagCYVRlY2lhzhqvnEoajGz+4a4SXLNbToZuUKY3B0fjbXVMsTyQW
	se5K3aHXUuwZlcUnA0KXiBWQNRO0Cb5i0Iya06xrJtQSkGlBOEz9fYsOcg7sP0VJ
	yqmLBQsQOIBLBAkr6OkqdevuZ0oOd1QIt5clfz1G72GaRPM8o58zdR5J/jqgI8sJ
	VGv1FSmcmBINDPSh3DS2ExnXXTbQ4dcm7EUBkYkk947dCrJeDSb+c9E3vZkHuPPK
	PT0vVw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mhh05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:35:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a8db414c7so3361461cf.0
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786473313; x=1787078113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5cKNYN1YVV/K1jHg9iJCW7yGQ3ybLzpVvQJS3M//mQs=;
        b=BjWtxYE7IKF9uvnB0I0b9cEqv6LvAJOXVUWRa/4YuFmCMsR0kaNvEEcwehEtzMW28k
         I2E8+YNRzC2uksH2XwJZ8PuErRBLtmGBDWCAeP9SQPWeb1Cg/dII+vnlYeVaZ84FeaCV
         YzJBiz/by/6Adayo/Z1r0EQJ44dVvDrbFgrlErbN+Ge0iGIU4GzEpjWz1G/7zDWURXIP
         KSd2Cc83zLpnH2GPpXylOJ6bYuiQ5pK/rfcWKooWEjn5IV3JhlvMk8q+Mv41wTvDACn/
         BeMSCl5nyDWvM2OO0Yx/evkvdWxMFc7gBWkLx0tX+F9/9AeVWmjGSF+ZCnbnMKr/XdsY
         XBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473313; x=1787078113;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5cKNYN1YVV/K1jHg9iJCW7yGQ3ybLzpVvQJS3M//mQs=;
        b=ahtB6pZ3+5FC/OVVyeleBAY/7dAEHIDJMSWi36/OP/mKRhZHlrt2S48rHMEo+Be/Sc
         i4C+VRUlT4dmeAVzdrYUu46bE9N7tI2NwW2FKBqsQMCjo3m8QttfaXqGrz55oJ2tBQkQ
         XSOdf/zHKHychQ4GvfpzNOSMczez1DgUwlrdt/7kmRDIf+YafK6jq4gPlNi2JC45bdQ9
         OQVTMois2A+z0XoOrUEh/R2pAGTr8gnzuPXYxbtwGGqoF0Y3NjYhYjCw1G4FDlZB+XfZ
         Bu+KQf4iRc6wDVjPmaHER9jQXebsSHhbeM4qTylZNupJ978C1J2TD4WzGcoy6MqfO67y
         gOuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrOw1dmPVu78Mq1FTIEDeXW0usx5uccccpMujYw4Jy9WkoYqcAlDPt3pSre7vuL/8xzTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt6EdXBaP6/R0HKUWS72x1PbN9nWYqa65XTTL4gTkwY36iQPNo
	pOnmmZe4XkkHCxc06GpmE2ctfQgNdY9iOXXYuXqTmjqfV4WaIj2FhH6OV4ezgADHwEMQo8E2IN5
	9hPMQE7rQl40lgQS7kMt+QZ9OJutQmasklH8dz0UptCaiJyWvH1meN9yQ6QPzj6w=
X-Gm-Gg: AR+sD136WepJeaXZXNXiwsLBCn+WVw4QZi44u6YZldAtQLqT3VRwAcT77wRl/JKaivD
	wOc/NgP16ifUpJdDAYdl3JIVPcAH4MJ9Sz3Q3Rbis8VdViRoC/mp3jLMyrYxP+wr7pBuybnRKpY
	hmVqhQmCHLsG0hYjFMoeJOsnEUlUZpO2k2c/FNchqgZypBFk6gIyBumLbuIvD7DQrZZQek5KdJl
	XkvMzllBprGkiGNZowSnZo56XvWBlX+L5d/O92TPCkgJUubudBgG8Nh5O0pNSgm0giZsS9QvqOA
	ewG2/9FfSCK2OlC33l2bkOhPr6eeDBdSLH2XrfIZP9tc9DgMqVqBVqRy1jeQuk6fbW0UwjR64Jy
	G+ihGXdrNMphDpo33wB32mgUQ+zhpk3aiJrTr+rgRXQ==
X-Received: by 2002:ac8:58ca:0:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-52d586946b4mr43853151cf.37.1786473312893;
        Tue, 11 Aug 2026 11:35:12 -0700 (PDT)
X-Received: by 2002:ac8:58ca:0:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-52d586946b4mr43852861cf.37.1786473312462;
        Tue, 11 Aug 2026 11:35:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997ad79e5csm3958745e9.3.2026.08.11.11.35.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 11:35:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
Subject: [PATCH 8/8] hw/cpu: Move system-specific cpu_exec_realize() to cpu-system.c
Date: Tue, 11 Aug 2026 20:34:10 +0200
Message-ID: <20260811183410.22428-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nozpQTIs4NC462shr6xcmwOAvbIznjE1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXwlHrdkFzWozt
 oQVtExEshc3wLRjithIaieIDTkNfQZBSt35WY7Et69wXOLzZl7A+e70tjSaHf9s8AX7rjK9Hvip
 LZnTTl/uwyJYSDEFHhfBjgYqX7FAHnY06POD/Z9iO6s2Ox6Dn4y0iuXWnIoddfataKRSP2vZM1W
 Q4fM8QUwDRwuxbV5nOEg4dwhjkBmnpOv0KrVuM4WGOV7GofIohG0SvEHGQ05PFwlotAj6g0C6Ip
 MfonVZ0r0nzkivpYIyPIY3ZqSFj/w3JgLgpLBifmXLHM4i8CtqkVn8o6TyaBzd3xUee0TK70zCF
 cFMnj0f1N51HTExxlnu8nL9WUwkxQBGZUcXISkPGBRwNHE/w09YbL0PcHSHA62t7qvu4g+tyqHu
 Nb8uZAzms5B0AOIF6t1+n52CCcAqIV+HkoyJcN87YQTgHiCWtTWdTyBj7UhSvHwoq/jKzbFujJx
 0yvZRT/SAJxqHgkFjDg==
X-Proofpoint-ORIG-GUID: nozpQTIs4NC462shr6xcmwOAvbIznjE1
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7b6b61 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pilchTG5AImVgDdFcq4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX4YiWW+Cg71ye
 BrnuzXYzNqzk94E2k4NHuQSJwKUr2Znf2C3x/uHTWz9PIQhcX6iBhfJZgdP75FzMCNyBfim6skB
 KSs/0ZlkaVo/6HRtn6cpeLZsZotPME4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155

Current cpu_exec_realize() body only contains system-mode
related code. Move that method out of cpu-common.c to
cpu-system.c, removing the system / machine mentions in
this common file. Add an empty stub for user-mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-internal.h |  1 +
 hw/core/cpu-common.c   | 24 ------------------------
 hw/core/cpu-system.c   | 26 ++++++++++++++++++++++++++
 hw/core/cpu-user.c     |  5 +++++
 4 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/hw/core/cpu-internal.h b/hw/core/cpu-internal.h
index ae6a31bca2d..44715b44329 100644
--- a/hw/core/cpu-internal.h
+++ b/hw/core/cpu-internal.h
@@ -15,6 +15,7 @@ void cpu_class_init_props(DeviceClass *dc);
 void cpu_exec_class_post_init(CPUClass *cc);
 
 void cpu_exec_init(CPUState *cpu);
+void cpu_exec_realize(CPUState *cpu, Error **errp);
 
 void cpu_vmstate_register(CPUState *cpu);
 void cpu_vmstate_unregister(CPUState *cpu);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cd7c8763cf5..4f4c87f33a0 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -33,7 +33,6 @@
 #include "exec/log.h"
 #include "exec/gdbstub.h"
 #include "system/tcg.h"
-#include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
 #ifdef CONFIG_PLUGIN
@@ -246,29 +245,6 @@ bool cpu_common_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
-static void cpu_exec_realize(CPUState *cpu, Error **errp)
-{
-    Object *machine = qdev_get_machine();
-
-    /* qdev_get_machine() can return something that's not TYPE_MACHINE
-     * if this is one of the user-only emulators; in that case there's
-     * no need to check the ignore_memory_transaction_failures board flag.
-     */
-    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
-
-        if (mc) {
-            cpu->ignore_memory_transaction_failures =
-                mc->ignore_memory_transaction_failures;
-        }
-    }
-
-    if (DEVICE(cpu)->hotplugged) {
-        cpu_synchronize_post_init(cpu);
-        cpu_resume(cpu);
-    }
-}
-
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     cpu_exec_realize(CPU(dev), errp);
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 8a9f2fcea84..feadfb5af00 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,10 +25,12 @@
 #include "exec/target_page.h"
 #include "system/memory.h"
 #include "qemu/target-info.h"
+#include "hw/core/boards.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
 #include "migration/vmstate.h"
+#include "system/hw_accel.h"
 #include "system/tcg.h"
 #include "cpu-internal.h"
 
@@ -221,6 +223,30 @@ static int cpu_common_pre_load(void *opaque)
     return 0;
 }
 
+void cpu_exec_realize(CPUState *cpu, Error **errp)
+{
+    Object *machine = qdev_get_machine();
+
+    /* qdev_get_machine() can return something that's not TYPE_MACHINE
+     * if this is one of the user-only emulators; in that case there's
+     * no need to check the ignore_memory_transaction_failures board flag.
+     */
+    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
+        MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+        if (mc) {
+            cpu->ignore_memory_transaction_failures =
+                mc->ignore_memory_transaction_failures;
+        }
+    }
+
+    if (DEVICE(cpu)->hotplugged) {
+        cpu_synchronize_post_init(cpu);
+        cpu_resume(cpu);
+    }
+
+}
+
 static bool cpu_common_exception_index_needed(void *opaque)
 {
     CPUState *cpu = opaque;
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index c2cb00a85d3..1e38c88f9bd 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -38,6 +38,11 @@ void cpu_exec_init(CPUState *cpu)
     /* nothing to do */
 }
 
+void cpu_exec_realize(CPUState *cpu, Error **errp)
+{
+    /* nothing to do */
+}
+
 void cpu_vmstate_register(CPUState *cpu)
 {
     assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
-- 
2.53.0

