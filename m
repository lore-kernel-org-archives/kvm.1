Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32223344044
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610003; cv=none; b=CW4DNJyn2Y4+b5kddV6q9ZMuxAlgrHzwAOF3o3QbBEeGWlWF16+DtjiasUH4MZ4HbpWXotjiUzRnQtimwycQX5i4lNrRpqEUs4UPdoHkjnDF4kS0l7r9j1quamiIws8+81x5goyAD77ZWtkyB7HQ9lCj8qeHaimw2IFJAVt+AsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610003; c=relaxed/simple;
	bh=3IrAb4bb7AtCN47+hlyOcTbfN95rYFmblINrJ93M88w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GE8Vi82FBlsCKc6HrH/sVT7qLEhVGUPalCJ5CCEY1ZIPrgwjdzcJAMsQ4jF+eLmBzG8UTvlQxh7UyayL/PcyxxvmJRXT0LfV5XVDmA+Blsps8yAgHJpnbOPVju7BwXR4Kv1pd/TTEcXSmdKWA3Sr86WWC63KTCSxQkC9rp/4b6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p1RjU15b; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p1RjU15b"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAInja1228387;
	Tue, 16 Jun 2026 11:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n8WvYGs25F/48/tvk
	hiOnzWM6MgyGgqsCkskOjjmMRg=; b=p1RjU15bZ4NNi+WwHxSeiwj+cvasm5Y1n
	XBySJJ8Ey85XAmKYAl5fVgJYrHxRiSY6WvcZ34eRhkGjUNB+wFnUu5kjteJq+M8E
	ZfctIXdZFnhYsjz7vLkRcpPlK6xZ+nOwHnpx7h/THeT2D17jLSmr+A5bbeLmUTvL
	5K1LdoL+XQ/F8h/oGPm4TITmqh4IBUL0h+0hm/WPsoPCUuNxbl2or8AU3Q0tLEAk
	eLYgyQBR7pAlJ2WtA3ZggxIFOfVcKxLZ8Q5F6kRxUgA8mDgiMwSxSwnFB1mFV02W
	y8UQMhATpH7/4a+Q0avlRJoSu9dWG/WwkqZsKUwcj0Gs1dZfQkPxg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm5bm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:39:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GBYhCF012004;
	Tue, 16 Jun 2026 11:39:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk330c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:39:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GBdpV561342076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 11:39:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7460820049;
	Tue, 16 Jun 2026 11:39:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6679720040;
	Tue, 16 Jun 2026 11:39:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 11:39:48 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] target/ppc/kvm: Add support for querying host compatibility mode
Date: Tue, 16 Jun 2026 17:09:14 +0530
Message-ID: <20260616113915.25589-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616113915.25589-1-amachhiw@linux.ibm.com>
References: <20260616113915.25589-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX0LivrA0rqoDG
 tDNYcFdvJ1COGXm0k4hcsSEGPXOL7qLU7FY1uRey4QsXx6wDWVsgczkG2m+04kce+6KXNCySlbM
 MWGGP6E1EmgqztAJDUkS63BuZrJXo6k=
X-Proofpoint-GUID: tyadm6yUtHZ_qObKBc4tXYUrK84CeE4c
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a31360c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=cv104ikJZnni9qh6AyoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX14Bdf3Ov0F3P
 cWZh4L/ICxpIt+WYVbPGXVm7I1axYa6n0eroGkFBt/3hmEuND5uuoRLXd5VsvMgFDNoFWyUAsTo
 k3Zs7bJkKBH2lOEDokMg5PWquLCNSB1VYbPa80BczGYg3vKJ/aKOhRiCSvQG87Lim8dBN2QXSVO
 bGHjX5qR9xEN9JaXPs9D+iZvnzHVTlp53ZLrHhuEx5vfhk4y38cAnwb2ZIqR+UwV/VPjumgR3sY
 g4xZgXY1TfKAwDkmb/6aN1Ct05CeTAqqqH2llY4opPS9G/Ht7n9hcmvckY4nWBA8b2zYWtTUFiq
 csdq4s6/pIRDLvBp7pbALQCYLE7oAxezJJbBI1LiQGmLhbBA5ENCFD6LCmLnY4Osolg9lf8zEOS
 WQKpMMkrtlvW3uJx1/L6xLDVVXmtdmkigzjsvBASqOaDKDYMjLhccD/waPcVFOhWNKqsWBjc76Q
 Jo8Vlr10f0ZoeL1uzwg==
X-Proofpoint-ORIG-GUID: 2yWu-0cuJRBluJriMR_xO-yplNvc0apB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160115

Add infrastructure to query the host CPU compatibility mode via the
KVM_PPC_GET_COMPAT_CAPS ioctl. This allows QEMU to determine if the
host is running in a compatibility mode (e.g., a Power11 processor
operating in Power10 compatibility mode).

The kvmppc_get_compat_caps() function queries KVM for host compatibility
capabilities with size field validation for ABI compatibility between
QEMU and the kernel. The kvm_ppc_host_compat_pvr() function derives the
effective PVR based on the compatibility mode reported by KVM.

Additionally, cas_check_pvr() in hw/ppc/spapr_hcall.c is updated to
prevent fallback to raw mode when the host is running in compatibility
mode. This ensures that nested guests cannot exceed the host's
compatibility level.

If the capability is not supported or the query fails, the functions
return 0, allowing fallback to existing behavior.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c | 14 ++++++++++
 target/ppc/kvm.c     | 65 ++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h | 16 +++++++++++
 3 files changed, 95 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 60ba215e8611..68c29fbe141b 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1135,6 +1135,7 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
 {
     bool explicit_match = false; /* Matched the CPU's real PVR */
     uint32_t best_compat = 0;
+    uint32_t compat_host_pvr = 0;
     int i;
 
     /*
@@ -1162,6 +1163,19 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
         }
     }
 
+    if (explicit_match) {
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
index b94c2997a07f..9e5006e0c2cd 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2602,6 +2602,71 @@ bool kvmppc_supports_ail_3(void)
     return cap_ail_mode_3;
 }
 
+#if defined(TARGET_PPC64)
+static target_ulong kvmppc_get_compat_caps(void)
+{
+    struct kvm_ppc_compat_caps host_compat;
+    target_ulong host_caps;
+    int ret;
+
+    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_COMPAT_CAPS)) {
+        return 0;
+    }
+
+    /* Initialize the structure with size field for forward compatibility */
+    memset(&host_compat, 0, sizeof(host_compat));
+    host_compat.size = sizeof(host_compat);
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
+    if (ret < 0) {
+        fprintf(stderr, "KVM: failed to get host capabilities\n");
+        return 0;
+    }
+
+    /*
+     * Validate the returned size matches our structure size.
+     * The kernel validates that userspace provides sufficient size before
+     * the ioctl, and returns its own structure size. A mismatch indicates
+     * a version incompatibility between QEMU and the kernel.
+     */
+    if (host_compat.size != sizeof(host_compat)) {
+        fprintf(stderr, "KVM: host_compat size mismatch (expected %zu, got %lu)\n",
+                sizeof(host_compat), host_compat.size);
+        return 0;
+    }
+
+    host_caps = host_compat.compat_capabilities;
+    return host_caps;
+}
+
+uint32_t kvm_ppc_host_compat_pvr(void)
+{
+    uint32_t compat_host_pvr = 0;
+    int cap_idx = 0;
+    target_ulong host_caps = kvmppc_get_compat_caps();
+
+    host_caps = host_caps & KVM_PPC_COMPAT_BITMASK;
+    if (host_caps) {
+        cap_idx = 63 - __builtin_ctzll(host_caps);
+        switch (cap_idx) {
+        case KVM_PPC_COMPAT_CAP_P9_IDX:
+            compat_host_pvr = CPU_POWERPC_POWER9_DD22;
+            break;
+        case KVM_PPC_COMPAT_CAP_P10_IDX:
+            compat_host_pvr = CPU_POWERPC_POWER10_DD20;
+            break;
+        case KVM_PPC_COMPAT_CAP_P11_IDX:
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
index 742881231e16..5970e7383740 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -81,6 +81,17 @@ bool kvmppc_supports_ail_3(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
+
+/*
+ * Bit position indices for KVM_PPC_COMPAT_CAP_* capabilities.
+ * These represent the result of (63 - bit_number) for each capability bit.
+ * Used for identifying which compatibility mode is supported by the host.
+ */
+#define KVM_PPC_COMPAT_CAP_P9_IDX   1  /* 63 - 62 */
+#define KVM_PPC_COMPAT_CAP_P10_IDX  2  /* 63 - 61 */
+#define KVM_PPC_COMPAT_CAP_P11_IDX  3  /* 63 - 60 */
+
+uint32_t kvm_ppc_host_compat_pvr(void);
 void kvmppc_check_papr_resize_hpt(Error **errp);
 int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
 int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
@@ -440,6 +451,11 @@ static inline PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
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

