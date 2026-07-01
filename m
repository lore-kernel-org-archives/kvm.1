Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C99285CAE
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782883458; cv=none; b=JUU63yic4Kss8SnKGpglVJb6S6i76iCKpyVSrkIQGf6DSzuPuQamrMTrPEON9QldCmO9M7kEGK3vXxNoqQgcDSvdWUcE5Zq6o0LL8WTGnIkQNCpFDzYHgamEsoL18bArI9W3VFEQHW98G/XPseNmJvU8JevEOKcQo1GzD/aQDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782883458; c=relaxed/simple;
	bh=3R5apKdnYyzkvehP/7AI+1wMJ3hAMyL++CjZPbVI93w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Urh5vzLsY97nu7SA+pLEO+RgCYl/9cipW1GiQTUEIW0kG1dPTj4mbHBxSApMDJXml+ZKgQeqcTqmG/jPDLOK5yy2kLNmUHlJDG3PufDkquoZFc5Q6SIz2/HDaVz/hRR2Aq0eoMLQVHM3xdwon7Tasl2W4oOOyNpVqAhLVgzg2Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fhfV7Rc2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fhfV7Rc2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613IPal3925383;
	Wed, 1 Jul 2026 05:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ycHh8YWky6M2U5Wpc
	gzdlLDTxNHEDLB2b4+wAt3PiEo=; b=fhfV7Rc2k3QLL1bM2dLWKXNhU3ML6GxjL
	4G8oTZX/8AhXyejPV8va5MEO9pSjSM4uAjlflnKFHuqblP40VkaxEHhCvK8iZAJW
	l6haIKzV9qaUFTkI1o7fOMiuV47N5bqC1zbPPHWsqt7e//8R8TsfnGENxdLlad6D
	LgM91yiLIb6M5oQfmp+B8pHi1AWL1yGgWkiLZvy34CBVzQ+3/vQtx4hUoHgBYHgJ
	V1KXP7rqO3iutmNsB3FvHaR4szgWfGEljQSjPWlt6x4rU54Z7qmESybunj19xhyD
	bumksWcXeIQCa4shxg3X3edfK9WH6XdfxQdwfYFyHkjiApNkQWBbw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe2q49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:24:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6615Jabh005574;
	Wed, 1 Jul 2026 05:24:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqdy1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:24:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6615O5VO42991962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 05:24:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78ED220049;
	Wed,  1 Jul 2026 05:24:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE3A120040;
	Wed,  1 Jul 2026 05:24:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 05:24:02 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH v4 2/3] target/ppc/kvm: Add support for querying host compatibility mode
Date: Wed,  1 Jul 2026 10:53:40 +0530
Message-ID: <20260701052341.62289-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701052341.62289-1-amachhiw@linux.ibm.com>
References: <20260701052341.62289-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UUhOgQjF6XzooNUPOEoOFW7IAZZwOnxI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA1MiBTYWx0ZWRfX5yCPodqPAoUh
 FmZQRbC8HHCl2d/fNTPWLeDyIqtr3p8eWd95eidl7L5lsBd7i8/NpPff3KWHmQ4wzvSjjsS0NKH
 4B3lCSnZn0L80xBOv/X/8GywmOQYrwo=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44a47a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MQa1r56DKncGqAxa_z4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA1MiBTYWx0ZWRfX4rWPsaq8Ep6k
 Yb3I9OLDr3WtUVU3bmuZFN5ubXYQQVvD2tQMnOYWaunQLy5aQ3h/74ll1YdeWs3rz3THulD4QC9
 w5z3y7GXNnLxI373XYQJZlJY+tYSQw8WFpNY6FN2pb51cCA9PAiP4RZ1K0jshuAiu0OFj1dSCeD
 q7QSBMdwyoDJ/tt53eJ6KRWI+EDh6Sy853FYFKPNoO5UQYwC51kNTYRvnVTI01xxZC3QAhL0m3W
 SrNgYFs+2Shh9ARXruPpZvEU5wmlWoFQ5KTEBtg9iBRR5SXHz6vfuoW/y57cA37FXWRfYWOmcUa
 KPcHrqDh1d99BYjUc2yHRUfKayCntjHEu/85SEeELmC9GhqQ5QSFPOYKyz0kFE2o1HvOZyFcRYP
 8WUwLu2k4CawThYHl1fcg9/PNZ/U0V6/VXWWUws2odtir+Vds6sknj+iFu7c9orMrHucreDPDXy
 j+LRQcznX+NQ+nKXjxA==
X-Proofpoint-ORIG-GUID: HkHNPIdDznWlxOzZZsVKjlqYY89b2cvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010052

Add infrastructure to query the host CPU compatibility mode via the
KVM_PPC_GET_COMPAT_CAPS ioctl. This allows QEMU to determine if the
host is running in a compatibility mode (e.g., a Power11 processor
operating in Power10 compatibility mode).

The kvmppc_get_compat_caps() function issues the ioctl and returns the
compat_capabilities bitmap. The kvm_ppc_host_compat_pvr() function derives
the effective PVR from the bitmap using ctz64() to find the lowest set
bit (highest supported compat level in IBM MSB-0 numbering).

The struct kvm_ppc_compat_caps places 'size' first and userspace sets it
to sizeof(struct kvm_ppc_compat_caps) before calling the ioctl. The kernel
uses copy_struct_from/to_user() to handle forward and backward ABI
compatibility: an older userspace with a smaller struct gets trailing fields
zero-padded. When newer userspace passes a larger struct to an older kernel
(usize > ksize), the kernel unconditionally returns -E2BIG and writes its
own ksize back into host_compat.size. QEMU detects this, validates the
returned size against KVM_PPC_COMPAT_CAPS_SIZE_VER0, and retries with that
size.

Additionally, cas_check_pvr() in hw/ppc/spapr_hcall.c is updated to
prevent fallback to raw mode when the host is running in compatibility
mode. This ensures that nested guests cannot exceed the host's
compatibility level. The call is guarded with kvm_enabled() since
kvm_ppc_host_compat_pvr() invokes kvm_vm_ioctl() which dereferences
kvm_state; without the guard, a TCG guest on a CONFIG_KVM=y binary
would segfault.

If the capability is not supported or the query fails, the functions
return 0, allowing fallback to existing behavior.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v4:
- Replaced fprintf(stderr, ...) with error_report() for error reporting
  in kvmppc_get_compat_caps().
- Replaced __builtin_ctzll() with the portable ctz64() helper.
- Simplified kvm_ppc_host_compat_pvr() to switch directly on the
  capability bit value (e.g. KVM_PPC_COMPAT_CAP_POWER9) instead of a
  derived index, removing the KVM_PPC_COMPAT_CAP_P*_IDX defines from
  kvm_ppc.h.
- Dropped the post-ioctl size mismatch check; it is not meaningful with
  the copy_struct_from/to_user() model.
- Added a function comment to kvm_ppc_host_compat_pvr().
- Guarded the kvm_ppc_host_compat_pvr() call in cas_check_pvr() with
  kvm_enabled() to prevent a segfault when QEMU is built with
  CONFIG_KVM=y but run as a TCG guest (kvm_state is NULL in that case).

 hw/ppc/spapr_hcall.c | 14 +++++++++
 target/ppc/kvm.c     | 75 ++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h |  7 +++++
 3 files changed, 96 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 23bcd788daf6..708902934cff 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1136,6 +1136,7 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
 {
     bool explicit_match = false; /* Matched the CPU's real PVR */
     uint32_t best_compat = 0;
+    uint32_t compat_host_pvr = 0;
     int i;
 
     /*
@@ -1163,6 +1164,19 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
         }
     }
 
+    if (explicit_match && kvm_enabled()) {
+        compat_host_pvr = kvm_ppc_host_compat_pvr();
+        /*
+         * If the host is booted in a compatibility mode, do not try booting in
+         * the raw mode as it may allow KVM guests to boot with a higher CPU
+         * version compared to what host was booted with; which should not be
+         * allowed.
+         */
+        if (compat_host_pvr) {
+            explicit_match = false;
+        }
+    }
+
     *raw_mode_supported = explicit_match;
 
     /* Parsing finished */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b94c2997a07f..b1b596f004ef 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2602,6 +2602,81 @@ bool kvmppc_supports_ail_3(void)
     return cap_ail_mode_3;
 }
 
+#if defined(TARGET_PPC64)
+static target_ulong kvmppc_get_compat_caps(void)
+{
+    struct kvm_ppc_compat_caps host_compat;
+    int ret;
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_COMPAT_CAPS)) {
+        return 0;
+    }
+
+    /*
+     * Set size to sizeof(struct kvm_ppc_compat_caps) so the kernel applies
+     * copy_struct_from/to_user() versioning. size must be >= VER0.
+     */
+    memset(&host_compat, 0, sizeof(host_compat));
+    host_compat.size = sizeof(host_compat);
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
+    if (ret == -E2BIG && host_compat.size >= KVM_PPC_COMPAT_CAPS_SIZE_VER0) {
+        /*
+         * Kernel is older and knows only a smaller struct version. It
+         * wrote back its ksize into host_compat.size. Retry with that
+         * size so the kernel accepts the call.
+         *
+         * When a VER1 struct is introduced, add a check here:
+         *   if (host_compat.size >= KVM_PPC_COMPAT_CAPS_SIZE_VER1) { ... }
+         */
+        uint64_t ksize = host_compat.size;
+        memset(&host_compat, 0, sizeof(host_compat));
+        host_compat.size = ksize;
+        ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
+    }
+
+    if (ret < 0) {
+        error_report("KVM: failed to get host CPU compat capabilities: %s",
+                     strerror(-ret));
+        return 0;
+    }
+
+    return host_compat.compat_capabilities & KVM_PPC_COMPAT_BITMASK;
+}
+
+/*
+ * Return the effective host PVR based on the CPU compatibility mode
+ * reported by KVM. Returns 0 if no compat mode is active or the
+ * capability is not supported, in which case the caller falls back
+ * to the raw hardware PVR.
+ */
+uint32_t kvm_ppc_host_compat_pvr(void)
+{
+    uint32_t compat_host_pvr = 0;
+    uint64_t cap_idx = 0;
+    target_ulong host_caps = kvmppc_get_compat_caps();
+
+    if (host_caps) {
+        cap_idx = 1ULL << ctz64(host_caps);
+        switch (cap_idx) {
+        case KVM_PPC_COMPAT_CAP_POWER9:
+            compat_host_pvr = CPU_POWERPC_POWER9_DD22;
+            break;
+        case KVM_PPC_COMPAT_CAP_POWER10:
+            compat_host_pvr = CPU_POWERPC_POWER10_DD20;
+            break;
+        case KVM_PPC_COMPAT_CAP_POWER11:
+            compat_host_pvr = CPU_POWERPC_POWER11_DD20;
+            break;
+        default:
+            break;
+        }
+    }
+
+    return compat_host_pvr;
+}
+#endif /* TARGET_PPC64 */
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 742881231e16..195dbaac5e17 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -81,6 +81,8 @@ bool kvmppc_supports_ail_3(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
+
+uint32_t kvm_ppc_host_compat_pvr(void);
 void kvmppc_check_papr_resize_hpt(Error **errp);
 int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
 int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
@@ -440,6 +442,11 @@ static inline PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     return NULL;
 }
 
+static inline uint32_t kvm_ppc_host_compat_pvr(void)
+{
+    return 0;
+}
+
 static inline void kvmppc_check_papr_resize_hpt(Error **errp)
 {
 }
-- 
2.50.1 (Apple Git-155)

