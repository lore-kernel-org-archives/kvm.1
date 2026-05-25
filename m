Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E673446B9;
	Mon, 25 May 2026 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702613; cv=none; b=Dzybeya4Sa/FDzG7olhYIRIFiWkRmS5qbg+wWxZOmCXGpTjsAVak3Z6wD5hfYddTsYXPpVrmq5Lvc3iwIP1l9SuRjv4FFFq9MEgus4AC7E2fv6Q3pyw8lJWZzj/CtYIDgNXYJdghof8r/2UrJqusrOKY3uYq0iaiVcWMeA0cCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702613; c=relaxed/simple;
	bh=vBtTxuF+6QSUb5qSCHMCNQW+GIVPoINBXctkzCtL+nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+qKmotlyoJx/JyqrmcPFUgUbqRlpJhKhslUZjnq8qxI02a3Dt8wzdFCDVdpauKH/9Otxjq2d8DnrXYsq1qyTcohH1wWDKItKVa8K4VLDAYfNV9CETv/CGopJ5xqKjuj6ZDzELVrHCcb5neOrX/Y1mXWMIwk0k+06YsJvZnabvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O65OIzVe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O65OIzVe"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P6d1Pn2602665;
	Mon, 25 May 2026 09:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XSi27LaIZDS
	YfIkF6hAAkA0fQqKRxuANHSMrzpNnmkA=; b=O65OIzVeqFP/9Veln9cB8tAKw5W
	Dm4VAscQwNeI200WaQVkuUJpWe7+CyXvTDbI3a+fxuDDyNxMVjxppYz8ZKMvZBoG
	rcfbZx4LHFcTzkqU7qDixZPEF1X1hp7aFTD9nXKr7RY1CQ5zb8tZLtjKT12ij/h4
	EOnQK1y+7+xcyP72nsD4/gts5XE9/M1L0kwZbzlGl42rBRUyjAA6tI1G1H6lNxsX
	6uNR36UAvP80RDjuhrVmom/7yWqC2rh9gTrSc8OZSDVFysf3DgCdwwYZaMmVB6Uw
	23MQbAbZ4zNZg7mnF2UZe8nI1GwJnTZGGLVRwFlOKxPsnt03ZFuj/ypBtlw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb36t699e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:49:50 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64P9nleh019450;
	Mon, 25 May 2026 09:49:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5ajeh9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:49:47 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64P9nlog019435;
	Mon, 25 May 2026 09:49:47 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64P9nl3H019431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:49:47 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 68DC32266A; Mon, 25 May 2026 15:19:46 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>,
        Thomas Gleixner <tglx@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH v5 2/2] RISC-V: KVM: AIA: Make HGEI number management fully per-CPU
Date: Mon, 25 May 2026 15:19:45 +0530
Message-ID: <20260525094945.3721783-3-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com>
References: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: v5yknUmkNLwe1L7yDJfaps23EAQWEf9y
X-Authority-Analysis: v=2.4 cv=Fto1OWrq c=1 sm=1 tr=0 ts=6a141b3e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1Uz5Pcmo5m1ThD7f2wUA:9
X-Proofpoint-ORIG-GUID: v5yknUmkNLwe1L7yDJfaps23EAQWEf9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEwMCBTYWx0ZWRfX4seI+C4+kwHU
 76xBci+9WAhkwC7cUZlxnCS7dSdkaC3dTJGLJ8ubq9jlPXS9IWOn52Uv2BgswDUWRcEgREGNC4+
 uEfn7k4sqrfaaAU5GM3FahSMBm92WafQCA5MFL8J+UB8p+9z9FJBSEBZTsrAI7uGvoeTT9dhTE7
 qXPKGWxmwZrfVqzB11R2aGunpeVgXZxNm46RTehcWVDdXyKFpaaBDDGLU+QOCgSwHmtREpTM0Tz
 iLTyikQcf2nWNUzcFoqX/FSxs59lJPkSrKyX6784MS8kIZcIOpbCMLx4HocYeDAg5uF8eeSbUqA
 YRTXJy2YUl1uD97tlODpHMoQaOS7ZMefUl6umkqUS0EENzkd/wAgM8PM8bGiLu9VhYPsgnh+Wm3
 IzEcLUfHOcg5ShhUayHcv+MfjxdcUc6Ubcg9hIBJW/PNQYP80biaE6oM8O5QlJpA/kmC6M2V0Lm
 DUtpXWfELrDCoV+2aEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250100

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Previously, the number of Hypervisor Guest External Interrupt (HGEI)
lines was stored in a single global variable `kvm_riscv_aia_nr_hgei`
and assumed to be the same for all HARTs. This assumption does not
hold on heterogeneous RISC-V SoCs where different cores may expose
different HGEIE CSR widths.

Introduce `nr_hgei` field into the per-CPU `struct aia_hgei_control`
and probe the actual supported HGEI count for the current HART in
`kvm_riscv_aia_enable()` using the standard RISC-V CSR probe technique:

    csr_write(CSR_HGEIE, -1UL);
    nr = fls_long(csr_read(CSR_HGEIE));
    if (nr)
        nr--;

All HGEI allocation, free and disable paths (`kvm_riscv_aia_free_hgei()`,
`kvm_riscv_aia_disable()`, etc.) now use the per-CPU value instead of
the global one.

The global `kvm_riscv_aia_nr_hgei` now represents the minimum number
of HGEI lines across HARTs and can be used to check whether HGEI
support is available or not.

This makes KVM AIA robust on big.LITTLE-style asymmetric platforms.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/include/asm/kvm_aia.h |  2 +-
 arch/riscv/kvm/aia.c             | 88 +++++++++++++++++++-------------
 arch/riscv/kvm/aia_device.c      |  4 +-
 arch/riscv/kvm/main.c            |  8 +--
 4 files changed, 60 insertions(+), 42 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index b04ecdd1a860..c67ec5ac0a14 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -79,7 +79,7 @@ struct kvm_vcpu_aia {
 
 #define irqchip_in_kernel(k)		((k)->arch.aia.in_kernel)
 
-extern unsigned int kvm_riscv_aia_nr_hgei;
+extern atomic_t kvm_riscv_aia_nr_hgei;
 extern unsigned int kvm_riscv_aia_max_ids;
 DECLARE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
 #define kvm_riscv_aia_available() \
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 5ec503288555..bafb009c5ce5 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -21,13 +21,15 @@
 
 struct aia_hgei_control {
 	raw_spinlock_t lock;
+	bool free_bitmap_initialized;
 	unsigned long free_bitmap;
 	struct kvm_vcpu *owners[BITS_PER_LONG];
+	unsigned int nr_hgei;
 };
 static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
 static int hgei_parent_irq;
 
-unsigned int kvm_riscv_aia_nr_hgei;
+atomic_t kvm_riscv_aia_nr_hgei;
 unsigned int kvm_riscv_aia_max_ids;
 DEFINE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
 
@@ -452,7 +454,7 @@ void kvm_riscv_aia_free_hgei(int cpu, int hgei)
 
 	raw_spin_lock_irqsave(&hgctrl->lock, flags);
 
-	if (hgei > 0 && hgei <= kvm_riscv_aia_nr_hgei) {
+	if (hgei > 0 && hgei <= hgctrl->nr_hgei) {
 		if (!(hgctrl->free_bitmap & BIT(hgei))) {
 			hgctrl->free_bitmap |= BIT(hgei);
 			hgctrl->owners[hgei] = NULL;
@@ -486,26 +488,18 @@ static irqreturn_t hgei_interrupt(int irq, void *dev_id)
 
 static int aia_hgei_init(void)
 {
-	int cpu, rc;
-	struct irq_domain *domain;
 	struct aia_hgei_control *hgctrl;
+	struct irq_domain *domain;
+	int cpu, rc;
 
 	/* Initialize per-CPU guest external interrupt line management */
 	for_each_possible_cpu(cpu) {
 		hgctrl = per_cpu_ptr(&aia_hgei, cpu);
 		raw_spin_lock_init(&hgctrl->lock);
-		if (kvm_riscv_aia_nr_hgei) {
-			hgctrl->free_bitmap =
-				BIT(kvm_riscv_aia_nr_hgei + 1) - 1;
-			hgctrl->free_bitmap &= ~BIT(0);
-		} else
-			hgctrl->free_bitmap = 0;
+		hgctrl->free_bitmap_initialized = false;
+		hgctrl->free_bitmap = 0;
 	}
 
-	/* Skip SGEI interrupt setup for zero guest external interrupts */
-	if (!kvm_riscv_aia_nr_hgei)
-		goto skip_sgei_interrupt;
-
 	/* Find INTC irq domain */
 	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
 					  DOMAIN_BUS_ANY);
@@ -529,25 +523,60 @@ static int aia_hgei_init(void)
 		return rc;
 	}
 
-skip_sgei_interrupt:
 	return 0;
 }
 
 static void aia_hgei_exit(void)
 {
-	/* Do nothing for zero guest external interrupts */
-	if (!kvm_riscv_aia_nr_hgei)
-		return;
-
 	/* Free per-CPU SGEI interrupt */
 	free_percpu_irq(hgei_parent_irq, &aia_hgei);
 }
 
 void kvm_riscv_aia_enable(void)
 {
+	const struct imsic_global_config *gc;
+	const struct imsic_local_config *lc;
+	struct aia_hgei_control *hgctrl;
+	unsigned long flags;
+	int aia_nr_hgei;
+
 	if (!kvm_riscv_aia_available())
 		return;
 
+	gc = imsic_get_global_config();
+	lc = (gc) ? this_cpu_ptr(gc->local) : NULL;
+	hgctrl = this_cpu_ptr(&aia_hgei);
+
+	/* Figure-out number of bits in HGEIE */
+	csr_write(CSR_HGEIE, -1UL);
+	hgctrl->nr_hgei = fls_long(csr_read(CSR_HGEIE));
+	csr_write(CSR_HGEIE, 0);
+	if (hgctrl->nr_hgei)
+		hgctrl->nr_hgei--;
+
+	/*
+	 * Number of usable per-HART HGEI lines should be minimum of
+	 * per-HART IMSIC guest files and number of bits in HGEIE.
+	 */
+	if (lc)
+		hgctrl->nr_hgei = min((ulong)hgctrl->nr_hgei, lc->nr_guest_files);
+	else
+		hgctrl->nr_hgei = 0;
+
+	/* Update the number of IMSIC guest files across all HARTs */
+	aia_nr_hgei = atomic_read(&kvm_riscv_aia_nr_hgei);
+	do {
+		if (aia_nr_hgei <= hgctrl->nr_hgei)
+			break;
+	} while (!atomic_try_cmpxchg(&kvm_riscv_aia_nr_hgei, &aia_nr_hgei, hgctrl->nr_hgei));
+
+	raw_spin_lock_irqsave(&hgctrl->lock, flags);
+	if (!hgctrl->free_bitmap_initialized) {
+		hgctrl->free_bitmap = (hgctrl->nr_hgei) ? GENMASK_ULL(hgctrl->nr_hgei, 1) : 0;
+		hgctrl->free_bitmap_initialized = true;
+	}
+	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+
 	csr_write(CSR_HVICTL, aia_hvictl_value(false));
 	csr_write(CSR_HVIPRIO1, 0x0);
 	csr_write(CSR_HVIPRIO2, 0x0);
@@ -588,7 +617,7 @@ void kvm_riscv_aia_disable(void)
 
 	raw_spin_lock_irqsave(&hgctrl->lock, flags);
 
-	for (i = 0; i <= kvm_riscv_aia_nr_hgei; i++) {
+	for (i = 0; i <= hgctrl->nr_hgei; i++) {
 		vcpu = hgctrl->owners[i];
 		if (!vcpu)
 			continue;
@@ -628,26 +657,15 @@ int kvm_riscv_aia_init(void)
 		return -ENODEV;
 	gc = imsic_get_global_config();
 
-	/* Figure-out number of bits in HGEIE */
-	csr_write(CSR_HGEIE, -1UL);
-	kvm_riscv_aia_nr_hgei = fls_long(csr_read(CSR_HGEIE));
-	csr_write(CSR_HGEIE, 0);
-	if (kvm_riscv_aia_nr_hgei)
-		kvm_riscv_aia_nr_hgei--;
-
-	/*
-	 * Number of usable HGEI lines should be minimum of per-HART
-	 * IMSIC guest files and number of bits in HGEIE
-	 */
+	/* Set initial value of IMSIC guest files across all HARTs */
 	if (gc)
-		kvm_riscv_aia_nr_hgei = min((ulong)kvm_riscv_aia_nr_hgei,
-					    gc->nr_guest_files);
+		atomic_set(&kvm_riscv_aia_nr_hgei, gc->nr_guest_files);
 	else
-		kvm_riscv_aia_nr_hgei = 0;
+		atomic_set(&kvm_riscv_aia_nr_hgei, 0);
 
 	/* Find number of guest MSI IDs */
 	kvm_riscv_aia_max_ids = IMSIC_MAX_ID;
-	if (gc && kvm_riscv_aia_nr_hgei)
+	if (gc)
 		kvm_riscv_aia_max_ids = gc->nr_guest_ids + 1;
 
 	/* Initialize guest external interrupt line management */
diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index 3d1e81e2a36b..be83c2d5fc30 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -71,7 +71,7 @@ static int aia_config(struct kvm *kvm, unsigned long type,
 				 * external interrupts (i.e. non-zero
 				 * VS-level IMSIC pages).
 				 */
-				if (!kvm_riscv_aia_nr_hgei)
+				if (!atomic_read(&kvm_riscv_aia_nr_hgei))
 					return -EINVAL;
 				break;
 			default:
@@ -628,7 +628,7 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
 	 */
 
 	/* Initialize default values in AIA global context */
-	aia->mode = (kvm_riscv_aia_nr_hgei) ?
+	aia->mode = (atomic_read(&kvm_riscv_aia_nr_hgei)) ?
 		KVM_DEV_RISCV_AIA_MODE_AUTO : KVM_DEV_RISCV_AIA_MODE_EMUL;
 	aia->nr_ids = kvm_riscv_aia_max_ids - 1;
 	aia->nr_sources = 0;
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index cb8a65273c1f..0924c75100a2 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -168,10 +168,6 @@ static int __init riscv_kvm_init(void)
 
 	kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
 
-	if (kvm_riscv_aia_available())
-		kvm_info("AIA available with %d guest external interrupts\n",
-			 kvm_riscv_aia_nr_hgei);
-
 	kvm_riscv_setup_vendor_features();
 
 	kvm_register_perf_callbacks();
@@ -182,6 +178,10 @@ static int __init riscv_kvm_init(void)
 		return rc;
 	}
 
+	if (kvm_riscv_aia_available())
+		kvm_info("AIA available with %d guest external interrupts\n",
+			 atomic_read(&kvm_riscv_aia_nr_hgei));
+
 	return 0;
 }
 module_init(riscv_kvm_init);
-- 
2.43.0

