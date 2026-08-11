Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BBE381B01
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473278; cv=none; b=FI2MTCnShqGErVKlFxfzxZYHhXKh3Kv/bZNvlK8h87l0jPEKJS3QvxkKn+F9g42vzMv7p38VezAXjNPo3BcZI6vogLUWl5oy076QXRgvDjNp5y3MpAbjHEml14VLTB5bMPddpM146FGUwhjP2NYfPzIARFNZyji3EIR9jNX2hHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473278; c=relaxed/simple;
	bh=IYSMZRy5d7RFYTWrIv1x8T+a4sBe0z+VXDdK6tWRk04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtfxEENn2HmC2n3uMFC0QzDm14lrOb4n8xOyWzFZgYuF7NmPHy8x3VcKnztH1D46DD3BEFCpna4/IRGJCZan6qO4tSI0XuWYxRnpAZcvtHIRvk+xzF+Od1s76U++NVcE/GRDV8TCL9dQMsPhrjZ5CMubDPyHhYVBjw4DixaW4UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W4ZnKQyG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HLdaOEO2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W4ZnKQyG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HLdaOEO2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGNhLH2311296
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g/3XAp8gWD+xk92avLJ9ckLrbA+mG6c0lKgx8FjorAg=; b=W4ZnKQyGudgYfdvg
	vR0atE4NCPEQq7o7k8asvxb8GUNsw6UsNRq1w1ie8aV/r9uQ+/6NQ8PunjksLvy9
	SqsLtm8k0TT+OYSUcYbT986G07zFrTLzqoAfhEBOmU/n/xGvhmw8XcuuDDTWeIuX
	IBNefVyPdIgzAyQYTu7uy1HBwceQU9FCzm5CleyCTkzT04ZpyPHmB9phc2zsJOe3
	ZlAVXFYn/j7LE6rCwOX/U/bmuSN9qp6fdxmMCp3DF7yZvHowePkd+Z4U4xa01ipU
	uj83AZqLXjQnWjfgj3zeRkKV0lwSq7GxQQ0SHw2aAcOTfEyKneSkAdwHaA3kIohT
	HRyOJg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049bsjck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:34:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5283fa0656dso17001451cf.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786473275; x=1787078075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g/3XAp8gWD+xk92avLJ9ckLrbA+mG6c0lKgx8FjorAg=;
        b=HLdaOEO24K/T3q0bwcjxrnola6x1OzqLmC2hA3eHUrS44EZ7eKsdj1BeveMbWzKKIE
         H718MeJ6JnISASQcgWUYxU/SwgCnqpzuW8wR2G7L0PjnFMu/HAgtmn8bFGeQmojuwMxX
         2ZNJxmeoZQmS+ZCC6gPhcElM8P/3gT4D2mGLA9feHTq9SZxwSesqyz4ly1g5mm2nr53x
         NtFiprknoo9slleDnFDQNL4M5HHqVKxlts1+pJdLG/aGNbDrwGudrhNq3dYf3w8wABOI
         fQo40uv6/uDXxIdEDbqz2BLqCQ+TT0NVBdAfavPaEhJRa95hmSgnDKMyACmd8QdOnwH6
         4BdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473275; x=1787078075;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/3XAp8gWD+xk92avLJ9ckLrbA+mG6c0lKgx8FjorAg=;
        b=gfUeJlH/2nyIQb+Bq4k15e2igpzGKPECP2xKdVQfLbwLd+OwhF/n/BBVDJpxMMQS1w
         RQdEioF7nRufK20S+Wkiub2XBhkQLgEdHuhIx6f4200pQqps8jKwcGHT00euRDJWbADc
         pY8Eu0rI0q0GPL5WB8Ny2oZFMqtKVqx5/TemTVGJzHOONApCgsI1QZWY7x8AbxDOQtG9
         2TjxWK09zHey5V3V2Hvvk1knpPJC8KbU3bDaYy4vpzCGO1KF85pMbr195oxV7zPJJA3n
         PZyX9yluBOd90TI++VcYLwVRXGiPKrkOTkIQs0VArEmC//M1Io/WjWDAA9/yH1NWf1at
         wenw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9vOtmQtEjp9pjMQV/hjvGg/mEfGJYxwFiY4JBjY0XNJKPfepnr5tzCjpt7fSyGh0Vnkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMJNxC6Bb+EuAbFvEoGDJGXEronfbWY35+pNrYD20VAdM/rW3
	wXf32yM+DjC7iQR+r9GaTd6sPntESPxeuzM706V+VOO60xu8L12sr+qLEwD1PCSqmlJusKHBu1/
	TqiwDLd259kCVCFCJOEcV1Zs0M4887UVn8NEUhq5CbCTzphv4LxvdTj0=
X-Gm-Gg: AR+sD11zWbd96iOLQCyKeri8DOLRzr3Mrfl7ttpLvtDX7q28uxtj/jh2qSesm7aiEAh
	Y4sNeUNQ5azhQmHDeTQ4hos5keLqOkpg0qp6X6mq3dM0fNqoJ/AuF6FHBo9r7I5YrISIdPBlbnY
	Lcfm+IJrt+wlqqZUNuhalnXgrhUqWEgLbyCwMInaJD/2mxh5FD6bpRddu8Ae0YC1NyRdKYr2BK6
	YwiY2zBSv2r4iowxUU7oJ0AjdXi1nUXfZ0IO4SAup60J3bVkvTeAm2HV9NWCBPA+8ZuqMZ/O7jO
	qeWyzYaD4mEsIXSoQgG26nS0GfPJ2sGvkx4074xm/nPTqfkxG2TZIv21CiUUwxXe5j8z5Euqy8o
	LUvugNoBvoVNt+gC3/9yu9TMQzhR+DXoKS6PrzmhRgA==
X-Received: by 2002:ac8:5a88:0:b0:51c:d1c:10e2 with SMTP id d75a77b69052e-52d602bc7d1mr22186701cf.12.1786473275461;
        Tue, 11 Aug 2026 11:34:35 -0700 (PDT)
X-Received: by 2002:ac8:5a88:0:b0:51c:d1c:10e2 with SMTP id d75a77b69052e-52d602bc7d1mr22186181cf.12.1786473275051;
        Tue, 11 Aug 2026 11:34:35 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4c10asm330805f8f.20.2026.08.11.11.34.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 11:34:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
Subject: [PATCH 3/8] hw/cpu: Move internal declarations to new 'cpu-internal.h' header
Date: Tue, 11 Aug 2026 20:34:05 +0200
Message-ID: <20260811183410.22428-4-philmd@oss.qualcomm.com>
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
X-Proofpoint-GUID: zZVOepJU0pylums6yJvkdFEDmDH6gIjB
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7b6b3c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=EfUqco5ci4O9xaNkQFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: zZVOepJU0pylums6yJvkdFEDmDH6gIjB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXy3F0O/eSruz4
 PHtNpo+84+mNKGFtQG2GFad4idrS4smAjhRurRmI4KSx4Y4jRpwIDpmDtVYllH5Wg9RMCqivsgN
 q928+HdMQzLSlypiqCbkXEq3AxV7SxoILSNU/X1TnQfKddHxRS7HY6HVCI1R3YUW+axmLu6pjc1
 c4frSbyKJv/ZAdNRIgwXKcxtczSBH+PeWg1h1ED/tNLS36C2nn5ExWT+A213sAqmfaaAYTK1Btg
 knFf2ko4K3MLsFTNIXab+L1hc6KYN+6Vzh+FjGoEn5JAXaveTxQowj4h0QL2Z6aS4Gh5a8MMLVc
 VTTkpr69DsKDIfbopc6xv9qIe1V4hz5fAE6ebTUCPXacU0zp6Nb5ID0QvycEDybTQgLLhYh+yIv
 vpqR5zAvotnbkhTY3JCoGeder2YszrcqxzSddIjbYkKlznkBclSHImMBl3N5VsdG8CQRW19QD9H
 ISUD6XUVa+v88rmAiyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX2x4a2Rm+v/Hj
 E5vbpD2UifR1/meSf5t8aLDvdEZ2m1RtrjR1wgujKLuFBsVoV03nRlNXbtHTzSnf5vZD6Vn+yBd
 ZYzxFR9ap+d3dXkSPerrqIWejQCnHCc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155

Some declarations are only used within hw/core/, in particular
by the 3 cpu-{common,user,system}.c. Restrict the declarations
scope by moving them to a new "cpu-internal.h" local header.

Rename cpu_exec_initfn() -> cpu_exec_init() because we usually
have the 'fn' suffix for handler, not API entry point methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-internal.h | 22 ++++++++++++++++++++++
 include/hw/core/cpu.h  |  6 ------
 hw/core/cpu-common.c   |  3 ++-
 hw/core/cpu-system.c   |  3 ++-
 hw/core/cpu-user.c     |  3 ++-
 5 files changed, 28 insertions(+), 9 deletions(-)
 create mode 100644 hw/core/cpu-internal.h

diff --git a/hw/core/cpu-internal.h b/hw/core/cpu-internal.h
new file mode 100644
index 00000000000..ae6a31bca2d
--- /dev/null
+++ b/hw/core/cpu-internal.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU private CPU interface between user / system modes)
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_CORE_CPU_INTERNAL_H
+#define HW_CORE_CPU_INTERNAL_H
+
+#include "hw/core/qdev.h"
+#include "hw/core/cpu.h"
+
+void cpu_class_init_props(DeviceClass *dc);
+void cpu_exec_class_post_init(CPUClass *cc);
+
+void cpu_exec_init(CPUState *cpu);
+
+void cpu_vmstate_register(CPUState *cpu);
+void cpu_vmstate_unregister(CPUState *cpu);
+
+#endif
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c5064a5449b..6490fb070f2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1178,12 +1178,6 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
  */
 void qemu_process_cpu_events(CPUState *cpu);
 
-/* $(top_srcdir)/cpu.c */
-void cpu_class_init_props(DeviceClass *dc);
-void cpu_exec_class_post_init(CPUClass *cc);
-void cpu_exec_initfn(CPUState *cpu);
-void cpu_vmstate_register(CPUState *cpu);
-void cpu_vmstate_unregister(CPUState *cpu);
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8c9ff25e04a..17d76580930 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -39,6 +39,7 @@
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin.h"
 #endif
+#include "cpu-internal.h"
 
 CPUState *cpu_by_arch_id(int64_t id)
 {
@@ -326,7 +327,7 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
-    cpu_exec_initfn(cpu);
+    cpu_exec_init(cpu);
 
     /*
      * Plugin initialization must wait until the cpu start executing
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 14eb4ed87f8..8a9f2fcea84 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -30,6 +30,7 @@
 #include "hw/core/sysemu-cpu-ops.h"
 #include "migration/vmstate.h"
 #include "system/tcg.h"
+#include "cpu-internal.h"
 
 bool cpu_has_work(CPUState *cpu)
 {
@@ -188,7 +189,7 @@ void cpu_exec_class_post_init(CPUClass *cc)
     g_assert(cc->sysemu_ops->has_work);
 }
 
-void cpu_exec_initfn(CPUState *cpu)
+void cpu_exec_init(CPUState *cpu)
 {
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index 25aa25ad240..c2cb00a85d3 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -11,6 +11,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/cpu.h"
 #include "migration/vmstate.h"
+#include "cpu-internal.h"
 
 static const Property cpu_user_props[] = {
     /*
@@ -32,7 +33,7 @@ void cpu_exec_class_post_init(CPUClass *cc)
     /* nothing to do */
 }
 
-void cpu_exec_initfn(CPUState *cpu)
+void cpu_exec_init(CPUState *cpu)
 {
     /* nothing to do */
 }
-- 
2.53.0

